import 'package:json_annotation/json_annotation.dart';

part 'assets_by_owner_query.g.dart';

@JsonSerializable()
class AssetsByOwnerQuery {
  final String ownerAddress;
  final int page;
  final int limit;

  AssetsByOwnerQuery({
    required this.ownerAddress,
    this.page = 1,
    this.limit = 1,
  });

  factory AssetsByOwnerQuery.fromJson(Map<String, dynamic> json) => _$AssetsByOwnerQueryFromJson(json);
  Map<String, dynamic> toJson() => _$AssetsByOwnerQueryToJson(this);
}
