// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NftContent _$NftContentFromJson(Map<String, dynamic> json) => NftContent(
      json_uri: json['json_uri'] as String,
      links: NftContentLinks.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NftContentToJson(NftContent instance) =>
    <String, dynamic>{
      'json_uri': instance.json_uri,
      'links': instance.links,
    };
