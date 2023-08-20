import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

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
class TokenResponse {
  final String access_token;
  final String token_type;
  final String refresh_token;
  final int expires_in;
  final String scope;

  TokenResponse({
    required this.access_token,
    required this.token_type,
    required this.refresh_token,
    required this.expires_in,
    required this.scope,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}




