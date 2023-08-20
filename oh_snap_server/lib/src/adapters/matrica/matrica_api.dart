import 'package:dio/dio.dart';
import 'package:oh_snap_server/src/adapters/matrica/token_response.dart';
import 'package:retrofit/retrofit.dart';

part 'matrica_api.g.dart';

@RestApi(baseUrl: "https://api.matrica.io")
abstract class MatricaApi {
  factory MatricaApi(Dio dio, {String baseUrl}) = _MatricaApi;

  @POST("/oauth2/token")
  // Content-Type: application/x-www-form-urlencoded
  Future<TokenResponse> fetchOauth2Token({
    @Header("Content-Type") String contentType = 'application/x-www-form-urlencoded',
    @Field("grant_type") String grantType = 'authorization_code',
    @Field("code") required String code,
    @Field("redirect_uri") required String redirectUri,
    @Field("client_id") required String clientId,
    @Field("client_secret") required String clientSecret,
    @Field("code_verifier") required String codeVerifier,
    /*
grant_type : Must be set to authorization_code
code : The code that you received.
redirect_uri : The callback redirect URI originally requested.
client_id : Your application ID.
client_secret (optional): Only if your application is set to "Private".
code_verifier : PKCE code verifier.
      * */
  });

}

