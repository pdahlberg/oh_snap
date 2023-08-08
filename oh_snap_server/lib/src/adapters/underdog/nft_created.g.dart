// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_created.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NftCreated _$NftCreatedFromJson(Map<String, dynamic> json) => NftCreated(
      projectId: json['projectId'] as int,
      transactionId: json['transactionId'] as String,
      nftId: json['nftId'] as int,
      mintAddress: json['mintAddress'] as String?,
    );

Map<String, dynamic> _$NftCreatedToJson(NftCreated instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'transactionId': instance.transactionId,
      'nftId': instance.nftId,
      'mintAddress': instance.mintAddress,
    };
