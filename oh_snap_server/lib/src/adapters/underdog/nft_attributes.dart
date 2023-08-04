import 'package:json_annotation/json_annotation.dart';

part 'nft_attributes.g.dart';

@JsonSerializable()
class NftAttributes {
  String source;

  NftAttributes({
    required this.source,
  });

  factory NftAttributes.fromJson(Map<String, dynamic> json) => _$NftAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$NftAttributesToJson(this);

  @override
  String toString() {
    return 'NftAttributes{$source}';
  }
}
