// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResult _$UploadResultFromJson(Map<String, dynamic> json) => UploadResult(
      status: json['status'] as String,
      message: json['message'] as String,
      creditsUsed: json['creditsUsed'] as int,
      remainingCredits: json['remainingCredits'] as int,
      file: json['file'] as String,
      permalink: json['permalink'] as String,
    );

Map<String, dynamic> _$UploadResultToJson(UploadResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'creditsUsed': instance.creditsUsed,
      'remainingCredits': instance.remainingCredits,
      'file': instance.file,
      'permalink': instance.permalink,
    };
