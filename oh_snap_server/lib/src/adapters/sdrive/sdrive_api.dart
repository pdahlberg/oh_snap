import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:oh_snap_server/src/adapters/sdrive/summarize_request.dart';
import 'package:oh_snap_server/src/adapters/sdrive/summarize_result.dart';
import 'package:oh_snap_server/src/adapters/sdrive/upload_result.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'sdrive_api.g.dart';

@RestApi(baseUrl: "https://sdrive.app/api/v3")
abstract class SDriveApi {
  factory SDriveApi(Dio dio, {String baseUrl}) = _SDriveApi;

  @POST("/upload")
  @MultiPart()
  Future<UploadResult> upload(
    @Part() File fileupload,
    @Part() String username,
    @Part() String apikey,
  );

  @POST("/ai/text/summarize")
  Future<SummarizeResult> summarize(
    @Body() SummarizeRequest request,
  );
}


