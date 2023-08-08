import 'package:json_annotation/json_annotation.dart';

part 'upload_result.g.dart';

@JsonSerializable()
class UploadResult {
  String status;
  String message;
  int creditsUsed;
  int remainingCredits;
  String file;
  String permalink;

  UploadResult({
    required this.status,
    required this.message,
    required this.creditsUsed,
    required this.remainingCredits,
    required this.file,
    required this.permalink,
  });

  factory UploadResult.fromJson(Map<String, dynamic> json) => _$UploadResultFromJson(json);
  Map<String, dynamic> toJson() => _$UploadResultToJson(this);

  @override
  String toString() {
    return 'UploadResult{status: $status, message: $message, creditsUsed: $creditsUsed, remainingCredits: $remainingCredits, file: $file, permalink: $permalink}';
  }
}

