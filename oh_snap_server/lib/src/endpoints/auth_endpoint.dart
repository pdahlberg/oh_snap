import 'package:dio/dio.dart';
import 'package:oh_snap_server/src/domain/service/query_service.dart';
import 'package:oh_snap_server/src/domain/service/time_service.dart';
import 'package:oh_snap_server/src/generated/auth_state.dart';
import 'package:oh_snap_server/src/generated/protocol.dart';
import 'package:pkce/pkce.dart';
import 'package:serverpod/serverpod.dart';

class AuthEndpoint extends Endpoint {

  // Move to DI, will Provider work on Server as well?
  final dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));
  final TimeService _timeService = TimeService();

  Future<String> authLink(Session session, String clientGeneratedSecret) async {
    session.log('Auth...');

    final pkcePair = PkcePair.generate();
    var codeVerifier = pkcePair.codeVerifier;
    session.log('codeVerifier: $codeVerifier');
    var codeChallenge = pkcePair.codeChallenge;
    session.log('codeChallenge: $codeChallenge');

    final clientId = session.passwords['matricaClientId'];
    //final codeVerifier = session.passwords['matricaCodeVerifier']; // Obviously not the right way, but for now wtf
    //final codeChallenge = session.passwords['matricaCodeChallenge']; // Obviously not the right way, but for now wtf
    final scope = 'profile';
    final redirectUri = 'https://app.ohsnap.app/auth/callback';
    //final redirectUri = 'https%3A%2F%2Fapp.ohsnap.app%2Fauth%2Fcallback';
    final state = clientGeneratedSecret;

    final preparedUrl = 'https://matrica.io/oauth2?client_id=$clientId&scope=$scope&response_type=code&redirect_uri=$redirectUri&code_challenge=$codeChallenge&code_challenge_method=S256&state=$state';
    final encoded = Uri.encodeFull(preparedUrl);
    session.log('Encoded url: $encoded');

    var now = _timeService.now();

    final authState = AuthState(
      state: state,
      codeverifier: codeVerifier,
      codechallenge: codeChallenge,
      url: encoded,
      modifiedAt: now,
      createdAt: now,
    );
    session.db.insert(authState);

    return encoded;
  }

  Future<User?> fetchUser(Session session, String clientGeneratedSecret) async {
    var queryService = QueryService(session);
    final authStateResult = await queryService.findAuthStateByState(clientGeneratedSecret);
    if(authStateResult == null) {
      throw Exception('User not found for this value');
    }
    final user = queryService.findUserByMatricaId(authStateResult.matricaid!);
    return user;
  }


  }

