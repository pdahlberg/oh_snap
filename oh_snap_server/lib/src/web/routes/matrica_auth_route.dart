import 'dart:io';

import 'package:serverpod/serverpod.dart';

class MatricaAuthRoute extends WidgetRoute {
  @override
  Future<WidgetJson> build(Session session, HttpRequest request) async {
    session.log('MatricaAuthRoute called: ${request.uri}');
    final widget = WidgetJson(
      object: {
        'message': 'Hello, world!',
      },
    );

    return widget;
  }
}
