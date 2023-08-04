// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NftResponse _$NftResponseFromJson(Map<String, dynamic> json) => NftResponse(
      id: json['id'] as String,
      content: NftContent.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NftResponseToJson(NftResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
    };

JsonRpcResponse _$JsonRpcResponseFromJson(Map<String, dynamic> json) =>
    JsonRpcResponse(
      jsonrpc: json['jsonrpc'] as String,
      result:
          JsonRpcListResponse.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonRpcResponseToJson(JsonRpcResponse instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'result': instance.result,
    };

JsonRpcListResponse _$JsonRpcListResponseFromJson(Map<String, dynamic> json) =>
    JsonRpcListResponse(
      total: json['total'] as int,
      limit: json['limit'] as int,
      page: json['page'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => NftResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JsonRpcListResponseToJson(
        JsonRpcListResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'limit': instance.limit,
      'page': instance.page,
      'items': instance.items,
    };
