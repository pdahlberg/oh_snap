import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:oh_snap_server/src/adapters/matrica/matrica_api.dart';
import 'package:oh_snap_server/src/domain/service/time_service.dart';
import 'package:pkce/pkce.dart';
import 'package:serverpod/serverpod.dart';

class MatricaAuthRoute extends WidgetRoute {

  // Move to DI, will Provider work on Server as well?
  final dio = Dio()..interceptors.add(LogInterceptor(responseBody: true)); // Provide a dio instance
  final dotenv = DotEnv(includePlatformEnvironment: true)..load();
  final TimeService _timeService = TimeService();

  @override
  Future<WidgetJson> build(Session session, HttpRequest request) async {
    dotenv.load();
    session.log('MatricaAuthRoute called: ${request.uri}, runmode: ${dotenv['runmode']}, PROJECT_NAME: ${dotenv['PROJECT_NAME']}');

    final pkcePair = PkcePair.generate();
    var codeVerifier = pkcePair.codeVerifier;
    session.log('codeVerifier: $codeVerifier');
    var codeChallenge = pkcePair.codeChallenge;
    session.log('codeChallenge: $codeChallenge');

    final clientId = dotenv['matrica_client_id'];
    final clientSecret = dotenv['matrica_client_secret'];
    final code = request.uri.queryParameters['code'];
    final state = request.uri.queryParameters['state'];

    assert(clientId != null, 'Matrica client ID is null');
    assert(clientSecret != null, 'Matrica client secret is null');
    assert(code != null, 'Code is null');
    session.log('Matrical callback state: $state');

    final matrica = MatricaApi(dio);
    matrica.fetchOauth2Token(
      code: code!,
      redirectUri: 'https://app.ohsnap.app/auth/callback',
      clientId: clientId!,
      clientSecret: clientSecret!,
      codeVerifier: 'QQ1ZmWjQdUFtCXZfc1SqxMJrPbCx0MztjjWtX6Glm8M',
    );

    final widget = WidgetJson(
      object: {
        'message': 'Welcome!',
      },
    );

    return widget;
  }
}
