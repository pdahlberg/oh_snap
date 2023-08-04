import 'package:json_annotation/json_annotation.dart';
import 'package:oh_snap_server/src/adapters/helius/nft_content_links.dart';

part 'nft_content.g.dart';

@JsonSerializable()
class NftContent {
  final String json_uri;
  final NftContentLinks links;

  NftContent({
    required this.json_uri,
    required this.links,
  });

  factory NftContent.fromJson(Map<String, dynamic> json) => _$NftContentFromJson(json);
  Map<String, dynamic> toJson() => _$NftContentToJson(this);
}
