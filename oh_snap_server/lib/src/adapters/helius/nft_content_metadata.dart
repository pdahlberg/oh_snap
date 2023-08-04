import 'package:json_annotation/json_annotation.dart';

part 'nft_content_metadata.g.dart';

@JsonSerializable()
class NftContentMetadata {
  final String name;

  NftContentMetadata({
    required this.name,
  });

  factory NftContentMetadata.fromJson(Map<String, dynamic> json) => _$NftContentMetadataFromJson(json);
  Map<String, dynamic> toJson() => _$NftContentMetadataToJson(this);
}

