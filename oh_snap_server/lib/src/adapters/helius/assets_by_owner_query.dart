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

@JsonSerializable(explicitToJson: true)
class AssetsByOwnerQueryCall {
  final String jsonrpc;
  final String id;
  final String method;
  final AssetsByOwnerQuery params;

  AssetsByOwnerQueryCall({
    this.jsonrpc = '2.0',
    this.id = 'call_id',
    this.method = 'getAssetsByOwner',
    required this.params,
  });

  factory AssetsByOwnerQueryCall.fromJson(Map<String, dynamic> json) => _$AssetsByOwnerQueryCallFromJson(json);
  Map<String, dynamic> toJson() => _$AssetsByOwnerQueryCallToJson(this);
}
