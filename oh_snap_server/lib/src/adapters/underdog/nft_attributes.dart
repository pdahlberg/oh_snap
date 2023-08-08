import 'package:json_annotation/json_annotation.dart';

part 'nft_attributes.g.dart';

@JsonSerializable()
class NftAttributes {
  String? source;
  int timestamp;
  String content;
  String document1;
  String document2;

  NftAttributes({
    this.source,
    required this.timestamp,
    required this.content,
    required this.document1,
    required this.document2,
  });

  factory NftAttributes.fromJson(Map<String, dynamic> json) => _$NftAttributesFromJson(json);
  Map<String, dynamic> toJson() => _$NftAttributesToJson(this);

  @override
  String toString() {
    return 'NftAttributes{$source}';
  }
}
