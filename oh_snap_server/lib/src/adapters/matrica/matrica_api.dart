import 'package:dio/dio.dart';
import 'package:oh_snap_server/src/adapters/matrica/access_token_response.dart';
import 'package:oh_snap_server/src/adapters/matrica/refresh_response.dart';
import 'package:oh_snap_server/src/adapters/matrica/user_profile_response.dart';
import 'package:retrofit/retrofit.dart';

part 'matrica_api.g.dart';

@RestApi(baseUrl: "https://api.matrica.io")
abstract class MatricaApi {
  factory MatricaApi(Dio dio, {String baseUrl}) = _MatricaApi;

  @POST('/oauth2/token')
  Future<AccessTokenResponse> fetchAccessToken({
    @Header('Content-Type') String contentType = 'application/x-www-form-urlencoded',
    @Field('grant_type') String grantType = 'authorization_code',
    @Field('code') required String code,
    @Field('redirect_uri') required String redirectUri,
    @Field('client_id') required String clientId,
    @Field('client_secret') required String clientSecret,
    @Field('code_verifier') required String codeVerifier,
  });

  @POST('/oauth2/token')
  Future<RefreshResponse> refreshAccessToken({
    @Header('Content-Type') String contentType = 'application/x-www-form-urlencoded',
    @Field('grant_type') String grantType = 'refresh_token',
    @Field('refresh_token') required String refreshToken,
    @Field('client_id') required String clientId,
    @Field('client_secret') required String clientSecret,
  });

  @GET('/oauth2/user/profile')
  Future<UserProfileResponse> fetchUserProfile({
    @Header('Authorization') required String authorization,
  });


}

