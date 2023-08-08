// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summarize_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummarizeResult _$SummarizeResultFromJson(Map<String, dynamic> json) =>
    SummarizeResult(
      status: json['status'] as String,
      summary: json['summary'] as String,
      length: json['length'] as int,
      creditsUsed: json['creditsUsed'] as int,
      remainingCredits: json['remainingCredits'] as int,
    );

Map<String, dynamic> _$SummarizeResultToJson(SummarizeResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'summary': instance.summary,
      'length': instance.length,
      'creditsUsed': instance.creditsUsed,
      'remainingCredits': instance.remainingCredits,
    };
