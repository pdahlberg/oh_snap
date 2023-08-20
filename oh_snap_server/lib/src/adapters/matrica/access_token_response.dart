import 'package:json_annotation/json_annotation.dart';

part 'access_token_response.g.dart';

/*
{
    "access_token": "qwertyuio123456",
    "token_type": "Bearer",
    "refresh_token": "qwertyuiopasdfghjk",
    "expires_in": 3600,
    "scope": "profile"
}
 */

@JsonSerializable()
class AccessTokenResponse {
  final String access_token;
  final String token_type;
  final String refresh_token;
  final int expires_in;
  final String scope;

  AccessTokenResponse({
    required this.access_token,
    required this.token_type,
    required this.refresh_token,
    required this.expires_in,
    required this.scope,
  });

  factory AccessTokenResponse.fromJson(Map<String, dynamic> json) => _$AccessTokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenResponseToJson(this);

  @override
  String toString() {
    return 'AccessTokenResponse{access_token: $access_token, token_type: $token_type, refresh_token: $refresh_token, expires_in: $expires_in, scope: $scope}';
  }

}




