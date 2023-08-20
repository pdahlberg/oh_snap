// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenResponse _$AccessTokenResponseFromJson(Map<String, dynamic> json) =>
    AccessTokenResponse(
      access_token: json['access_token'] as String,
      token_type: json['token_type'] as String,
      refresh_token: json['refresh_token'] as String,
      expires_in: json['expires_in'] as int,
      scope: json['scope'] as String,
    );

Map<String, dynamic> _$AccessTokenResponseToJson(
        AccessTokenResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'refresh_token': instance.refresh_token,
      'expires_in': instance.expires_in,
      'scope': instance.scope,
    };
