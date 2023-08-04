
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  // make sure you don't initiate your router
  // inside of the build function.
  const App({ super.key });

  @override
  Widget build(BuildContext context) {
    final GoRouter goRouter = Provider.of<AppRouter>(context, listen: false).router;

    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
    );
  }
}

