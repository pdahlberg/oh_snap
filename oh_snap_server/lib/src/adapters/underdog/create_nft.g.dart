// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_nft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNft _$CreateNftFromJson(Map<String, dynamic> json) => CreateNft(
      name: json['name'] as String,
      image: json['image'] as String,
      externalUrl: json['externalUrl'] as String,
      attributes:
          NftAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateNftToJson(CreateNft instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'externalUrl': instance.externalUrl,
      'attributes': instance.attributes,
    };
