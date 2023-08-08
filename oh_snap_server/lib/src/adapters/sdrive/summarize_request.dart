import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'summarize_request.g.dart';

@JsonSerializable()
class SummarizeRequest {
  String username;
  String apikey;
  String text;
  int length;

  SummarizeRequest({
    required this.username,
    required this.apikey,
    required this.text,
    required this.length,
  });

  factory SummarizeRequest.fromJson(Map<String, dynamic> json) => _$SummarizeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SummarizeRequestToJson(this);

}

