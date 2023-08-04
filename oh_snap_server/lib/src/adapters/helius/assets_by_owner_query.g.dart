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
