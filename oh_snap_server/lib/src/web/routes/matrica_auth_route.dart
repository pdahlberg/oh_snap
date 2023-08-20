import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oh_snap_server/src/adapters/matrica/matrica_api.dart';
import 'package:oh_snap_server/src/domain/service/time_service.dart';
import 'package:pkce/pkce.dart';
import 'package:serverpod/serverpod.dart';

class MatricaAuthRoute extends WidgetRoute {

  // Move to DI, will Provider work on Server as well?
  final dio = Dio()..interceptors.add(LogInterceptor(responseBody: true)); // Provide a dio instance
  final TimeService _timeService = TimeService();

  @override
  Future<WidgetJson> build(Session session, HttpRequest request) async {
    session.log('MatricaAuthRoute called: ${request.uri}');

    /*final pkcePair = PkcePair.generate();
    var codeVerifier = pkcePair.codeVerifier;
    session.log('codeVerifier: $codeVerifier');
    var codeChallenge = pkcePair.codeChallenge;
    session.log('codeChallenge: $codeChallenge');
*/
    final clientId = session.passwords['matricaClientId'];
    final clientSecret = session.passwords['matricaClientSecret'];
    final codeVerifier = session.passwords['matricaCodeVerifier'];
    final database = session.passwords['database'];
    final test = session.passwords['test'];
    final code = request.uri.queryParameters['code'];
    final state = request.uri.queryParameters['state'];
    final dog = session.passwords['underdogApikey'];

    session.log('clientId: $clientId, clientSecret: $clientSecret, code: $code, '
        'codeVerifier: $codeVerifier, database: $database, test value: $test, 2, dog: $dog');

    assert(clientId != null, 'Matrica client ID is null');
    var clientId2 = clientId!;

    assert(clientSecret != null, 'Matrica client secret is null');
    var clientSecret2 = clientSecret!;

    assert(code != null, 'Code is null');
    var code2 = code!;

    assert(codeVerifier != null, 'Code verifier is null');
    var codeVerifier2 = codeVerifier!;

    session.log('Matrical callback state: $state');

    final matrica = MatricaApi(dio);
    final accessTokenResult = await matrica.fetchAccessToken(
      code: code2,
      redirectUri: 'https://app.ohsnap.app/auth/callback',
      clientId: clientId2,
      clientSecret: clientSecret2,
      codeVerifier: codeVerifier2,
    );

    session.log('fetchAccessToken result: $accessTokenResult');

    /*final refreshedToken = await matrica.refreshAccessToken(
      refreshToken: accessTokenResult.refresh_token,
      clientId: clientId2,
      clientSecret: clientSecret2,
    );

    session.log('refreshAccessToken result: $refreshedToken');
    */

    final widget = WidgetJson(
      object: {
        'message': 'Welcome!',
      },
    );

    return widget;
  }
}
