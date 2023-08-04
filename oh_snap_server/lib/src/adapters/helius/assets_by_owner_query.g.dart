// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_by_owner_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetsByOwnerQuery _$AssetsByOwnerQueryFromJson(Map<String, dynamic> json) =>
    AssetsByOwnerQuery(
      ownerAddress: json['ownerAddress'] as String,
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 1,
    );

Map<String, dynamic> _$AssetsByOwnerQueryToJson(AssetsByOwnerQuery instance) =>
    <String, dynamic>{
      'ownerAddress': instance.ownerAddress,
      'page': instance.page,
      'limit': instance.limit,
    };

AssetsByOwnerQueryCall _$AssetsByOwnerQueryCallFromJson(
        Map<String, dynamic> json) =>
    AssetsByOwnerQueryCall(
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      id: json['id'] as String? ?? 'call_id',
      method: json['method'] as String? ?? 'getAssetsByOwner',
      params:
          AssetsByOwnerQuery.fromJson(json['params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssetsByOwnerQueryCallToJson(
        AssetsByOwnerQueryCall instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'method': instance.method,
      'params': instance.params.toJson(),
    };
