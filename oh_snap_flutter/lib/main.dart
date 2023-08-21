import 'package:flutter/material.dart';
import 'package:oh_snap_flutter/infra/production_environment.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
/*var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProductionEnvironment());
}
