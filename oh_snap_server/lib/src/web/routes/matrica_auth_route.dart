import 'dart:io';

import 'package:serverpod/serverpod.dart';

class MatricaAuthRoute extends WidgetRoute {
  @override
  Future<AbstractWidget> build(Session session, HttpRequest request) async {
    final widget = WidgetJson(
      object: {
        'message': 'Hello, world!',
      },
    );

    return Future.value(widget);
  }
}
