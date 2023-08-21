import 'package:json_annotation/json_annotation.dart';

part 'refresh_response.g.dart';

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
class RefreshResponse {
  final String? access_token;
  final String? token_type;
  final String? refresh_token;
  final int? expires_in;
  final String? scope;

  RefreshResponse({
    this.access_token,
    this.token_type,
    this.refresh_token,
    this.expires_in,
    this.scope,
  });

  factory RefreshResponse.fromJson(Map<String, dynamic> json) => _$RefreshResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshResponseToJson(this);

  @override
  String toString() {
    return 'RefreshResponse{access_token: $access_token, token_type: $token_type, refresh_token: $refresh_token, expires_in: $expires_in, scope: $scope}';
  }

}




