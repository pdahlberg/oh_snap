import 'dart:io';

import 'package:dio/dio.dart';
import 'package:oh_snap_server/src/adapters/matrica/matrica_api.dart';
import 'package:oh_snap_server/src/domain/service/query_service.dart';
import 'package:oh_snap_server/src/domain/service/time_service.dart';
import 'package:oh_snap_server/src/generated/protocol.dart';
import 'package:pkce/pkce.dart';
import 'package:serverpod/serverpod.dart';

class MatricaAuthRoute extends WidgetRoute {

  // Move to DI, will Provider work on Server as well?
  final dio = Dio()..interceptors.add(LogInterceptor(responseBody: true)); // Provide a dio instance
  final TimeService _timeService = TimeService();

  @override
  Future<WidgetJson> build(Session session, HttpRequest request) async {
    session.log('MatricaAuthRoute called: ${request.uri}');

    final clientId = session.passwords['matricaClientId'];
    final clientSecret = session.passwords['matricaClientSecret'];
    //final codeVerifier = session.passwords['matricaCodeVerifier']; // Obviously not the right way, but for now wtf
    final code = request.uri.queryParameters['code'];
    final state = request.uri.queryParameters['state'];

    //session.log('clientId: $clientId, clientSecret: $clientSecret, code: $code, '
    //    'codeVerifier: $codeVerifier, database: $database, test value: $test, 2, dog: $dog');

    assert(clientId != null, 'Matrica client ID is null');
    var clientId2 = clientId!;

    assert(clientSecret != null, 'Matrica client secret is null');
    var clientSecret2 = clientSecret!;

    assert(code != null, 'Code is null');
    var code2 = code!;

    //assert(codeVerifier != null, 'Code verifier is null');
    //var codeVerifier2 = codeVerifier!;

    assert(state != null, 'State is null');
    var state2 = state!;

    final authStateResult = await QueryService(session).findAuthStateByState(state2);
    assert(authStateResult != null, 'Auth state not found');
    final authState = authStateResult!;

    session.log('Matrical callback state: $state');

    final matrica = MatricaApi(dio);
    final accessTokenResult = await matrica.fetchAccessToken(
      code: code2,
      redirectUri: 'https://app.ohsnap.app/auth/callback',
      clientId: clientId2,
      clientSecret: clientSecret2,
      codeVerifier: authState.codeverifier,
    );

    session.log('fetchAccessToken result: $accessTokenResult');

    final userResponse = await matrica.fetchUserProfile(authorization: 'Bearer ${accessTokenResult.access_token}');
    final matricaId = userResponse.id;

    session.log('fetchUserProfile result: $userResponse');

    var backendUser = await QueryService(session).findUserByMatricaId(matricaId);
    if(backendUser == null) {
      backendUser = BackendUser(
        username: userResponse.username,
        matricaid: matricaId,
        matricaaccesstoken: accessTokenResult.access_token,
        matricaRefreshToken: accessTokenResult.refresh_token,
        credits: 50,
        modifiedAt: _timeService.now(),
        createdAt: _timeService.now(),
      );

      await session.db.insert(backendUser);
    } else {
      var changed = false;

      if(backendUser.username != userResponse.username) {
        backendUser.username = userResponse.username;
        changed = true;
      }

      if(backendUser.matricaaccesstoken != accessTokenResult.access_token) {
        backendUser.matricaaccesstoken = accessTokenResult.access_token;
        changed = true;
      }

      if(backendUser.matricaRefreshToken != accessTokenResult.refresh_token) {
        backendUser.matricaRefreshToken = accessTokenResult.refresh_token;
        changed = true;
      }

      if(changed) {
        backendUser.modifiedAt = _timeService.now();
        session.db.update(backendUser);
      }
    }

    authState.matricaid = matricaId;
    authState.modifiedAt = _timeService.now();
    await session.db.update(authState);

    /*final refreshedToken = await matrica.refreshAccessToken(
      refreshToken: accessTokenResult.refresh_token,
      clientId: clientId2,
      clientSecret: clientSecret2,
    );

    session.log('refreshAccessToken result: $refreshedToken');
    */

    final widget = WidgetJson(
      object: {
        'message': 'Welcome ${backendUser.username}!',
      },
    );

    return widget;
  }
}
