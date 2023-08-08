// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NftAttributes _$NftAttributesFromJson(Map<String, dynamic> json) =>
    NftAttributes(
      source: json['source'] as String?,
      timestamp: json['timestamp'] as int,
      content: json['content'] as String,
      document1: json['document1'] as String,
      document2: json['document2'] as String,
    );

Map<String, dynamic> _$NftAttributesToJson(NftAttributes instance) =>
    <String, dynamic>{
      'source': instance.source,
      'timestamp': instance.timestamp,
      'content': instance.content,
      'document1': instance.document1,
      'document2': instance.document2,
    };
