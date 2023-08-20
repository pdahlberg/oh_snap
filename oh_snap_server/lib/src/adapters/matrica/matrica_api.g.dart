// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrica_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MatricaApi implements MatricaApi {
  _MatricaApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.matrica.io';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AccessTokenResponse> fetchAccessToken({
    String contentType = 'application/x-www-form-urlencoded',
    String grantType = 'authorization_code',
    required String code,
    required String redirectUri,
    required String clientId,
    required String clientSecret,
    required String codeVerifier,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'grant_type': grantType,
      'code': code,
      'redirect_uri': redirectUri,
      'client_id': clientId,
      'client_secret': clientSecret,
      'code_verifier': codeVerifier,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AccessTokenResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: contentType,
    )
            .compose(
              _dio.options,
              '/oauth2/token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AccessTokenResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AccessTokenResponse> refreshAccessToken({
    String contentType = 'application/x-www-form-urlencoded',
    String grantType = 'refresh_token',
    required String refreshToken,
    required String clientId,
    required String clientSecret,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Content-Type': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'grant_type': grantType,
      'refresh_token': refreshToken,
      'client_id': clientId,
      'client_secret': clientSecret,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AccessTokenResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: contentType,
    )
            .compose(
              _dio.options,
              '/oauth2/token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AccessTokenResponse.fromJson(_result.data!);
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
