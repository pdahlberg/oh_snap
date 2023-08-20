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
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:http/http.dart' as http;

// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class SnapEndpoint extends Endpoint {

  // Move to DI, will Provider work on Server as well?
  final dio = Dio()..interceptors.add(LogInterceptor(responseBody: true)); // Provide a dio instance
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

    String filename = url
        .replaceAll('https://twitter.com/', 'twitter_')
        .replaceAll('/', '_');

    var post = Post(filename: filename, captureurl: url, createdAt: now, modifiedAt: now);
    await session.db.insert(post);

    final captureTask = Task(
      postId: post.id!,
      type: TaskType.capture,
      status: TaskStatus.pending,
      dependsOn: null,
      cost: 1,
      paid: 0,
      paymentRequirement: PaymentRequirement.none,
      createdAt: now,
      modifiedAt: now,
    );
    await session.db.insert(captureTask);

    final summarizeTask = Task(
      postId: post.id!,
      type: TaskType.summarize,
      status: TaskStatus.pending,
      dependsOn: captureTask.id!,
      cost: 1,
      paid: 0,
      paymentRequirement: PaymentRequirement.none,
      createdAt: now,
      modifiedAt: now,
    );
    await session.db.insert(summarizeTask);

    final previewTask = Task(
      postId: post.id!,
      type: TaskType.share,
      status: TaskStatus.pending,
      dependsOn: summarizeTask.id!,
      cost: 1,
      paid: 0,
      paymentRequirement: PaymentRequirement.none,
      createdAt: now,
      modifiedAt: now,
    );
    await session.db.insert(previewTask);

    final createNftTask = Task(
      postId: post.id!,
      type: TaskType.mint,
      status: TaskStatus.pending,
      dependsOn: previewTask.id!,
      cost: 1,
      paid: 0,
      paymentRequirement: PaymentRequirement.none,
      createdAt: now,
      modifiedAt: now,
    );
    await session.db.insert(createNftTask);

    //return SnapInfo(imageUrl: permalink);
    return post;
  }

  Future<void> _validate({
    required Session session,
    required bool test,
    required Task task,
    required String msg,
  }) async {
    if(!test) {
      task.status = TaskStatus.error;
      task.statusMsg = msg;
      await session.db.update(task);
    }
    assert(test, msg);
  }

  Future<void> _captureTask(Post post, Task task, Session session) async {
    await _validate(
      session: session,
      test: post.captureurl != null,
      task: task,
      msg: 'post.captureurl is null',
    );

    final (screenshot, textContent) = await _takeScreenshot(session, post.captureurl!, false);
    //String filename = '${_textToFilename(post.title!)}.png';
    final (screenshotPermalinkUrl, screenshotSdriveUrl) = await _upload(session, screenshot, 'png', 'image/png', post.filename);
    post.imageUrl = screenshotPermalinkUrl;
    post.text = textContent;
    session.log('Screenshot uploaded: $screenshotPermalinkUrl');
    await session.db.update(post);

    session.log('Task(${task.id}) captured');
    task.status = TaskStatus.completed;
    await session.db.update(task);
  }

  Future<void> _summarizeTask(Post post, Task task, Session session) async {
    await _validate(
      session: session,
      test: post.text != null,
      task: task,
      msg: 'post.text is null',
    );

    final summaryForTitle = await _summarize(session, post.text!);
    if(summaryForTitle != null) {
      if(summaryForTitle.length < 32) {
        post.title = summaryForTitle.trim(); // 32 is the NFT max name length
      } else {
        post.title = summaryForTitle.trim().substring(0, 32); // 32 is the NFT max name length
      }
    }
    await session.db.update(post);

    session.log('Task(${task.id}) summarized');
    task.status = TaskStatus.completed;
    await session.db.update(task);
  }

  Future<void> _sharePrevTask(Post post, Task task, Session session) async {
    await _validate(session: session, test: post.imageUrl != null, task: task, msg: 'post.imageUrl is null');
    await _validate(session: session, test: post.text != null, task: task, msg: 'post.text is null');
    await _validate(session: session, test: post.title != null, task: task, msg: 'post.title is null');
    await _validate(session: session, test: post.captureurl != null, task: task, msg: 'post.captureurl is null');

    var hasImage = true;
    String doc = _createSharablePreview(hasImage, post.imageUrl!, post.text!, post.title!, post.captureurl!);
    List<int> bytes = utf8.encode(doc);
    final (sharePreviewPermalinkUrl, sharePreviewSdriveUrl) = await _upload(session, bytes, 'html', 'text/html', post.filename);
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
        try {
          final post = await queryService.findPostById(task.postId);

          task.status = TaskStatus.inProgress;
          session.db.update(task);
          session.log('Processing task ${task.id} ${task.type}');

          if(task.type == TaskType.mint) {
            await _mintTask(session, post!, task);
          } else if(task.type == TaskType.capture) {
            await _captureTask(post!, task, session);
          } else if(task.type == TaskType.share) {
            await _sharePrevTask(post!, task, session);
          } else if(task.type == TaskType.summarize) {
            await _summarizeTask(post!, task, session);
          } else {
            session.log('Task type not implemented: ${task.type}');
            task.status = TaskStatus.pending;
            session.db.update(task);
          }
        } catch (e) {
          task.status = TaskStatus.error;
          task.statusMsg = e.toString();
          session.db.update(task);
          session.log('Processing task error: ${task.id} ${task.type} => $e');
        }
      } else {
        session.log('Task ${task.id} ${task.type} not ready');
      }
    }
  }



  Future<void> _mintTask(Session session, Post post, Task task) async {
    assert(post.imageUrl != null);
    assert(post.title != null);
    assert(post.shareUrl != null);
    assert(post.shareAltUrl != null);
    assert(post.text != null);

    final (jsonResponse, txId, exception) = await _createNft(
      session: session,
      nftName: post.title!,
      imageUrl: post.imageUrl!,
      source: post.captureurl!,
      shareUrl: post.shareUrl!,
      shareAltUrl: post.shareAltUrl!,
      content: post.text!,
    );

    if(exception != null) {
      task.status = TaskStatus.error;
      task.statusMsg = '$exception with body: $jsonResponse';
      session.log('Failed to mint NFT', level: LogLevel.error, exception: exception);
    } else {
      task.status = TaskStatus.completed;
      task.statusMsg = jsonResponse;
      post.transactionId = txId;
      await session.db.update(post);
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

  Future<(String, String)> _upload(Session session, List<int> bytes, String suffix, String contentType, String filename) async {
    final username = dotenv['sdrive_username']!;
    final apikey = dotenv['sdrive_apikey']!;

    final sdrive = SDriveApi(dio);
    final result = await sdrive.dioUpload(
      dio: dio,
      bytes: bytes,
      filename: filename,
      contentType: contentType,
      username: username,
      apikey: apikey,
    );

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
    } on DioException catch(e) {
      session.log('_createNft with underdog error: ${e.message} / ${e.response}', exception: e, level: LogLevel.error);
      var json = e.response?.toString();
      return (json, null, e);
    } on Exception catch(e) {
      return (null, null, e);
    }
  }
}

