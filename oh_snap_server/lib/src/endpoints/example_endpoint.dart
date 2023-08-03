import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:puppeteer/puppeteer.dart';

// This is an example endpoint of your server. It's best practice to use the
// `Endpoint` ending of the class name, but it will be removed when accessing
// the endpoint from the client. I.e., this endpoint can be accessed through
// `client.example` on the client side.

// After adding or modifying an endpoint, you will need to run
// `serverpod generate` to update the server and client code.
class ExampleEndpoint extends Endpoint {
  // You create methods in your endpoint which are accessible from the client by
  // creating a public method with `Session` as its first parameter. Supported
  // parameter types are `bool`, `int`, `double`, `String`, `DateTime`, and any
  // objects that are generated from your `protocol` directory. The methods
  // should return a typed future; the same types as for the parameters are
  // supported. The `session` object provides access to the database, logging,
  // passwords, and information about the request being made to the server.
  Future<String> hello(Session session, String url, String walletAddress, bool removeButtons) async {
    session.log('Snap the $url and send it to $walletAddress');

    await _takeScreenshot(url, removeButtons);

    session.log('Done with the screenshotting...');
    return 'Snap the $url and send it to $walletAddress';
  }

  Future<void> _takeScreenshot(String url, bool removeButtons) async {
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
    
    var screenshot = await element.screenshot();
    await File('/tmp/screenshot.png').writeAsBytes(screenshot);
    
    await browser.close();
  }
}
