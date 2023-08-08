import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'summarize_result.g.dart';

@JsonSerializable()
class SummarizeResult {
  String status;
  String summary;
  int length;
  int creditsUsed;
  int remainingCredits;

  SummarizeResult({
    required this.status,
    required this.summary,
    required this.length,
    required this.creditsUsed,
    required this.remainingCredits,
  });

  factory SummarizeResult.fromJson(Map<String, dynamic> json) => _$SummarizeResultFromJson(json);
  Map<String, dynamic> toJson() => _$SummarizeResultToJson(this);

  @override
  String toString() {
    return 'SummarizeResult{status: $status, summary: $summary, length: $length, creditsUsed: $creditsUsed, remainingCredits: $remainingCredits}';
  }
}

