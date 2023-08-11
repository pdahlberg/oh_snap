import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:oh_snap_server/src/adapters/sdrive/summarize_request.dart';
import 'package:oh_snap_server/src/adapters/sdrive/summarize_result.dart';
import 'package:oh_snap_server/src/adapters/sdrive/upload_result.dart';
import 'package:retrofit/retrofit.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;

part 'sdrive_api.g.dart';

const sdriveBaseUrl = "https://sdrive.app/api/v3";

@RestApi(baseUrl: sdriveBaseUrl)
abstract class SDriveApi {
  factory SDriveApi(Dio dio, {String baseUrl}) = _SDriveApi;

  /*@POST("/upload")
  @MultiPart()
  Future<UploadResult> upload(
    @Part() File fileupload,
    @Part() String username,
    @Part() String apikey,
  );*/

  @POST("/ai/text/summarize")
  Future<SummarizeResult> summarize(
    @Body() SummarizeRequest request,
  );

}

extension RetrofitPatch on SDriveApi {

  Future<UploadResult> dioUpload({
    required Dio dio,
    required List<int> bytes,
    required String filename,
    required String contentType,
    required String username,
    required String apikey,
  }) async {
    final formData = FormData.fromMap({
      'fileupload': MultipartFile.fromBytes(
        bytes,
        filename: filename,
        contentType: http_parser.MediaType.parse(contentType),
      ),
      'username': username,
      'apikey': apikey,
    });

    final uploadResponse = await dio.post(
      '$sdriveBaseUrl/upload',
      data: formData,
    );

    var json = jsonDecode(uploadResponse.toString());
    return UploadResult.fromJson(json);
  }

}
