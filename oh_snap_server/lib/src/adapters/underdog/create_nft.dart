import 'package:json_annotation/json_annotation.dart';
import 'package:oh_snap_server/src/adapters/underdog/nft_attributes.dart';

part 'create_nft.g.dart';

@JsonSerializable()
class CreateNft {
  String name;
  String image;
  String externalUrl;
  NftAttributes attributes;

  CreateNft({
    required this.name,
    required this.image,
    required this.externalUrl,
    required this.attributes,
  });

  factory CreateNft.fromJson(Map<String, dynamic> json) => _$CreateNftFromJson(json);
  Map<String, dynamic> toJson() => _$CreateNftToJson(this);

  @override
  String toString() {
    return 'CreateNft{$name, $image, $externalUrl}';
  }
}
