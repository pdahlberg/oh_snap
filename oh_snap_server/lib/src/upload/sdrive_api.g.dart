// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdrive_api.dart';

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

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SDriveApi implements SDriveApi {
  _SDriveApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://sdrive.app/api/v3';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UploadResult> upload(
    File fileupload,
    String username,
    String apikey,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(MapEntry(
      'fileupload',
      MultipartFile.fromFileSync(
        fileupload.path,
        filename: fileupload.path.split(Platform.pathSeparator).last,
      ),
    ));
    _data.fields.add(MapEntry(
      'username',
      username,
    ));
    _data.fields.add(MapEntry(
      'apikey',
      apikey,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UploadResult>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'multipart/form-data',
    )
            .compose(
              _dio.options,
              '/upload',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UploadResult.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
