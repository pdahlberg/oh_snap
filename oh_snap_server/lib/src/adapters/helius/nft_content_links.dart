import 'package:json_annotation/json_annotation.dart';

part 'nft_content_links.g.dart';

@JsonSerializable()
class NftContentLinks {
  final String image;

  NftContentLinks({
    required this.image,
  });

  factory NftContentLinks.fromJson(Map<String, dynamic> json) => _$NftContentLinksFromJson(json);
  Map<String, dynamic> toJson() => _$NftContentLinksToJson(this);
}
