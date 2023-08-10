import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:file/memory.dart';
import 'package:oh_snap_server/src/adapters/sdrive/sdrive_api.dart';
import 'package:oh_snap_server/src/adapters/sdrive/summarize_request.dart';
import 'package:oh_snap_server/src/adapters/underdog/create_nft.dart';
import 'package:oh_snap_server/src/adapters/underdog/nft_attributes.dart';
import 'package:oh_snap_server/src/adapters/underdog/underdog_api.dart';
import 'package:oh_snap_server/src/domain/common_extensions.dart';
import 'package:oh_snap_server/src/domain/service/query_service.dart';
import 'package:oh_snap_server/src/domain/service/time_service.dart';
import 'package:oh_snap_server/src/endpoints/share_preview_template.dart';
import 'package:oh_snap_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:puppeteer/puppeteer.dart';

// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class SnapEndpoint extends Endpoint {

  final dio = Dio(); //..interceptors.add(LogInterceptor(responseBody: true)); // Provide a dio instance
  final dotenv = DotEnv(includePlatformEnvironment: true)..load();
  final TimeService _timeService = TimeService();

  // You create methods in your endpoint which are accessible from the client by
  // creating a public method with `Session` as its first parameter. Supported
  // parameter types are `bool`, `int`, `double`, `String`, `DateTime`, and any
  // objects that are generated from your `protocol` directory. The methods
  // should return a typed future; the same types as for the parameters are
  // supported. The `session` object provides access to the database, logging,
  // passwords, and information about the request being made to the server.
  Future<Post> create(Session session, String url, String walletAddress, bool removeButtons) async {
    session.log('Snap the $url and send it to $walletAddress');

    var now = _timeService.now();

    final existing = await QueryService(session).findPostByCaptureUrl(url);
    if (existing != null) {
      session.log('Post already exists: $url');
      return existing;
    } else {
      session.log('Post capture for: $url');
    }

    var post = Post(captureurl: url, createdAt: now, modifiedAt: now);
    await session.db.insert(post);

    /*

    var captureTask = Task(
      postId: post.id!,
      type: TaskType.capture,
      dependsOn: null,
      cost: 1,
      paid: 0,
      paymentRequirement: PaymentRequirement.none,
      createdAt: now,
      modifiedAt: now,
    );
    await session.db.insert(captureTask);

    var summarizeTask = Task(
      postId: post.id!,
      type: TaskType.capture,
      dependsOn: captureTask.id!,
      cost: 1,
      paid: 0,
      paymentRequirement: PaymentRequirement.later,
      createdAt: now,
      modifiedAt: now,
    );
    await session.db.insert(summarizeTask);

     */
    var previewTask = Task(
      postId: post.id!,
      type: TaskType.share,
      status: TaskStatus.pending,
      dependsOn: null, // todo: summarizeTask.id!,
      cost: 1,
      paid: 0,
      paymentRequirement: PaymentRequirement.upfront,
      createdAt: now,
      modifiedAt: now,
    );
    await session.db.insert(previewTask);

    var createNftTask = Task(
      postId: post.id!,
      type: TaskType.mint,
      status: TaskStatus.pending,
      dependsOn: previewTask.id!,
      cost: 1,
      paid: 0,
      paymentRequirement: PaymentRequirement.upfront,
      createdAt: now,
      modifiedAt: now,
    );
    await session.db.insert(createNftTask);

    final (screenshot, textContent) = await _takeScreenshot(session, url, removeButtons);
    final (screenshotPermalinkUrl, screenshotSdriveUrl) = await _upload(session, screenshot, 'png');
    post.imageUrl = screenshotPermalinkUrl;
    post.text = textContent;
    session.log('Screenshot uploaded: $screenshotPermalinkUrl');

    final summaryForTitle = await _summarize(session, post.text!);
    if(summaryForTitle == null) {
      post.title = 'Untitled $now';
    } else {
      post.title = summaryForTitle;
    }

    await session.db.update(post);
    
    //return SnapInfo(imageUrl: permalink);
    return post;
  }

  /*Future<void> sharePrevTask(Session session) async {
    var queryService = QueryService(session);
    final tasks = await queryService.findTaskByTypeAndStatus(TaskType.mint, TaskStatus.pending);

    for(var task in tasks) {
      if(await _taskReady(task, queryService)) {
        task.status = TaskStatus.inProgress;
        session.db.update(task);

        final post = await queryService.findPostById(task.postId);
        session.log('Processing task ${task.id} ${task.type} since payment is ok');
        await _sharePrevTask(post!, session);
      }
    }

  }*/

  Future<void> _sharePrevTask(Post post, Task task, Session session) async {
    var hasImage = true;
    String doc = _createSharablePreview(hasImage, post.imageUrl!, post.text!, post.title!, post.captureurl!);
    List<int> bytes = utf8.encode(doc);
    final (sharePreviewPermalinkUrl, sharePreviewSdriveUrl) = await _upload(session, bytes, 'html');
    post.shareUrl = sharePreviewPermalinkUrl;
    post.shareAltUrl = sharePreviewSdriveUrl;
    await session.db.update(post);

    session.log('Task(${task.id}) share preview uploaded: $sharePreviewPermalinkUrl');
    task.status = TaskStatus.completed;
    await session.db.update(task);
  }

  bool _paymentOk(Task task) {
    switch(task.paymentRequirement) {
      case PaymentRequirement.none:     return true;
      case PaymentRequirement.later:    return true;
      case PaymentRequirement.upfront:  return task.paid >= task.cost;
    }
  }

  Future<bool> _taskReady(Task task, QueryService queryService) async {
    bool isReady = false;
    if(task.status == TaskStatus.pending && _paymentOk(task)) {
      if(task.dependsOn == null) {
        isReady = true;
      } else {
        Task? dependency = await queryService.findTaskById(task.dependsOn!);
        isReady = dependency?.let((entity) => entity.status == TaskStatus.completed) ?? true;
      }
    }
    return isReady;
  }

  Future<void> processTasks(Session session) async {
    var queryService = QueryService(session);
    final tasks = await queryService.findTaskByStatus(TaskStatus.pending);

    for(var task in tasks) {
      if(await _taskReady(task, queryService)) {

        final post = await queryService.findPostById(task.postId);

        session.log('Processing task ${task.id} ${task.type}');
        if(task.type == TaskType.mint) {
          task.status = TaskStatus.inProgress;
          session.db.update(task);
          await _taskToNft(session, post!, task);
        } else if(task.type == TaskType.share) {
          await _sharePrevTask(post!, task, session);
        } else {
          session.log('Task type not implemented: ${task.type}');
          task.status = TaskStatus.pending;
          session.db.update(task);
        }

      } else {
        session.log('Task ${task.id} ${task.type} not ready');
      }
    }
  }



  Future<void> _taskToNft(Session session, Post post, Task task) async {
    assert(post.imageUrl != null);
    assert(post.title != null);
    assert(post.shareUrl != null);
    assert(post.shareAltUrl != null);
    assert(post.text != null);

    final (createResponse, txId, exception) = await _createNft(
      session: session,
      nftName: post.title!,
      imageUrl: post.imageUrl!,
      source: post.captureurl!,
      shareUrl: post.shareUrl!,
      shareAltUrl: post.shareAltUrl!,
      content: post.text!,
    );

    if(createResponse != null) {
      task.status = TaskStatus.completed;
      task.statusMsg = createResponse;
      post.transactionId = txId;
      await session.db.update(post);
    } else {
      task.status = TaskStatus.error;
      task.statusMsg = exception.toString();
      session.log('Failed to mint NFT', level: LogLevel.error, exception: exception);
    }

    await session.db.update(task);
  }

  String _createSharablePreview(bool hasImage, String screenshotResultUrl, String content, String summary, String url) {
    var imageHeaders = '';
    if(hasImage) {
      imageHeaders = sharePreviewImageHeaderTemplate
          .replaceAll('{og:image}', screenshotResultUrl);
    }
    
    var contentDesc = content.length > 300 ? content.substring(0, 300) : content;
    var twitterDesc = content.length > 200 ? content.substring(0, 200) : content;
    
    final doc = sharePreviewTemplate
        .replaceAll('{og:title}', summary)
        .replaceAll('{og:description}', contentDesc)
        .replaceAll('{twitter:description}', twitterDesc)
        .replaceAll('{og:type}', 'article')
        .replaceAll('{og:url}', screenshotResultUrl)
        .replaceAll('{twitter:card}', hasImage ? 'summary_large_image' : 'summary')
        .replaceAll('{image_header}', imageHeaders)
        .replaceAll('{source_url}', url)
        .replaceAll('{og:image}', screenshotResultUrl)
        .replaceAll('{body}', content);
    return doc;
  }

  /*Future<Post> _capture(Session session, String url, String walletAddress, bool removeButtons) async {
    session.log('Snap the $url and send it to $walletAddress');
    //dotenv.load();

    var now = _timeService.now();

    //var post = Post(url: url, createdAt: now, modifiedAt: now);
    //session.db.insert(post);

    //final screenshot = await _takeScreenshot(url, removeButtons);
    //final permalink = await _upload(session, screenshot);
    //await _createNft(session, 'name', imageUrl, url);

    session.log('Done...');
    //return SnapInfo(imageUrl: permalink);
    return post;
  }*/

  Future<(List<int>, String)> _takeScreenshot(Session session, String url, bool removeButtons) async {
    var browser = await puppeteer.launch();
    var page = await browser.newPage();
    
    // Navigate the page to a URL
    await page.goto(url, wait: Until.networkIdle);
    var devTools = page.devTools;
    await devTools.client.send('Emulation.setEmulatedMedia', {'features': [{'name': 'prefers-color-scheme', 'value': 'dark'}]});
    // todo: PR to fix the upstream spelling error
    //await page.emulateMediaFeatures([MediaFeature.prefersColorsScheme('dark')]);
    //await page.emulateMediaFeatures([{ name: 'prefers-color-scheme', value: 'dark' }]);
    
    //await page.setViewport(DeviceViewport());
    
    if(removeButtons) {
      var removeSelector = '#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > section > div > div > div > div > div:nth-child(1) > div > div > article > div > div > div:nth-child(3) > div:nth-child(6)';
      //await page.$eval(removeSelector, el => el.remove());
      //page.evaluate(removeSelector, );
    }
    
    // sel0 =      '#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > section > div > div > div > div > div:nth-child(1) > div > div > article > div';
    var selector = '#react-root > div > div > div.css-1dbjc4n.r-18u37iz.r-13qz1uu.r-417010 > main > div > div > div > div > div > section > div > div > div > div > div:nth-child(1) > div > div';
    await page.waitForSelector(selector, timeout: Duration(seconds: 10));
    var element = await page.$(selector);

    var something = await page.evaluate<List>(r'''resultsSelector => {
  const anchors = Array.from(document.querySelectorAll(resultsSelector));
  return anchors.map(anchor => {
    return anchor.textContent;
  });
}''', args: [selector]);

    String str = something.join('\n');

    var screenshot = await element.screenshot();
    await browser.close();
    return (screenshot, str);
  }

  Future<String?> _summarize(Session session, String text, { int maxCharacters = 60 }) async {
    final username = dotenv['sdrive_username'];
    final apikey = dotenv['sdrive_apikey'];

    final sdrive = SDriveApi(dio);
    final result = await sdrive.summarize(SummarizeRequest(
      username: username!,
      apikey: apikey!,
      text: text,
      length: maxCharacters,
    ));

    if(result.status == 'success') {
      return result.summary;
    } else {
      session.log('Summarize failed: $result', level: LogLevel.error);
      return null;
    }
  }

  Future<(String, String)> _upload(Session session, List<int> bytes, String suffix) async {
    final timestamp = _timeService.now().millisecond.toString();
    var tempDir = Directory.systemTemp.path;
    File file = File('$tempDir/share_preview_$timestamp.$suffix')..writeAsBytesSync(bytes);
    final username = dotenv['sdrive_username']!;
    final apikey = dotenv['sdrive_apikey']!;

    final sdrive = SDriveApi(dio);
    final result = await sdrive.upload(file, username, apikey);
    session.log('Upload result: $result');
    return (result.permalink, result.file);
  }

  Future<(String?, String?, Exception?)> _createNft({
    required Session session,
    required String nftName,
    required String imageUrl,
    required String? source,
    required String shareUrl,
    required String shareAltUrl,
    required String content,
  }) async {
    final apikey = dotenv['underdog_apikey']!;
    final captureTimestamp = _timeService.nowMillis();

    final underdog = UnderdogApi(dio);
    //final result = await underdog.fetchProject('Bearer $apikey', 1);
    try {
      final result = await underdog.createNft('Bearer $apikey', 1, CreateNft(
        // todo: receiverAddress: ,
        name: nftName,
        image: imageUrl,
        externalUrl: shareUrl,
        attributes: NftAttributes(
          source: source,
          timestamp: captureTimestamp,
          content: content,
          document1: shareAltUrl,
          document2: shareUrl,
        ),
      ));
      session.log('_createNft with underdog result: $result');
      var json = jsonEncode(result.toJson());
      return (json, result.transactionId, null);
    } on Exception catch(e) {
      return (null, null, e);
    }
  }
}
