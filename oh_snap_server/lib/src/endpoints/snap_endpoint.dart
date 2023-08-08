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

  final dio = Dio(); // Provide a dio instance
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

    var post = Post(captureUrl: url, createdAt: now, modifiedAt: now);
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

    var previewTask = Task(
      postId: post.id!,
      type: TaskType.preview,
      dependsOn: captureTask.id!,
      cost: 1,
      paid: 0,
      paymentRequirement: PaymentRequirement.later,
      createdAt: now,
      modifiedAt: now,
    );
    await session.db.insert(previewTask);
     */

    var createNftTask = Task(
      postId: post.id!,
      type: TaskType.mint,
      dependsOn: null, // todo: captureTask.id!,
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
    post.title = summaryForTitle;

    var hasImage = true;
    String doc = _createSharablePreview(hasImage, screenshotPermalinkUrl, post.text!, post.title!, url);
    List<int> bytes = utf8.encode(doc);
    final (sharePreviewPermalinkUrl, sharePreviewSdriveUrl) = await _upload(session, bytes, 'html');
    post.shareUrl = sharePreviewPermalinkUrl;
    post.shareAltUrl = sharePreviewSdriveUrl;
    session.log('Share preview uploaded: $sharePreviewPermalinkUrl');

    // move to _taskToNft
    _taskToNft(session, post, createNftTask);
    /*await _createNft(
      session: session,
      nftName: summary,
      permalinkImage: screenshotPermalinkUrl,
      sdriveImage: screenshotSdriveUrl,
      source: url,
      permalinkSharePrev: sharePreviewPermalinkUrl,
      sdriveSharePrev: sharePreviewSdriveUrl,
      content: content,
    );*/

    //return SnapInfo(imageUrl: permalink);
    return post;
  }

  Future<void> _taskToNft(Session session, Post post, Task task) async {
    assert(post.imageUrl != null);
    assert(post.title != null);
    assert(post.shareUrl != null);
    assert(post.shareAltUrl != null);
    assert(post.text != null);

    await _createNft(
      session: session,
      nftName: post.title!,
      imageUrl: post.imageUrl!,
      source: post.captureUrl!,
      shareUrl: post.shareUrl!,
      shareAltUrl: post.shareAltUrl!,
      content: post.text!,
    );
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

  Future<String> _summarize(Session session, String text, { int maxCharacters = 60 }) async {
    final username = dotenv['sdrive_username'];
    final apikey = dotenv['sdrive_apikey'];

    final sdrive = SDriveApi(dio);
    final result = await sdrive.summarize(SummarizeRequest(
      username: username!,
      apikey: apikey!,
      text: text,
      length: maxCharacters,
    ));
    session.log('Summarize result: $result');
    return result.summary;
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

  Future<void> _createNft({
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
    final result = await underdog.createNft('Bearer $apikey', 1, CreateNft(
      name: nftName,
      image: imageUrl,
      attributes: NftAttributes(
        source: source,
        timestamp: captureTimestamp,
        content: content,
        document1: shareAltUrl,
        document2: shareUrl,
      ),
    ));
    session.log('underdog: $result');
  }
}
