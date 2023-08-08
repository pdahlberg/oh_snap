// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summarize_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummarizeRequest _$SummarizeRequestFromJson(Map<String, dynamic> json) =>
    SummarizeRequest(
      username: json['username'] as String,
      apikey: json['apikey'] as String,
      text: json['text'] as String,
      length: json['length'] as int,
    );

Map<String, dynamic> _$SummarizeRequestToJson(SummarizeRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'apikey': instance.apikey,
      'text': instance.text,
      'length': instance.length,
    };
