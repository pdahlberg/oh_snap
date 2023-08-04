import 'package:json_annotation/json_annotation.dart';
import 'package:oh_snap_server/src/adapters/helius/nft_content.dart';

part 'nft_response.g.dart';

@JsonSerializable()
class NftResponse {
  final String id;
  final NftContent content;

  NftResponse({
    required this.id,
    required this.content,
  });

  factory NftResponse.fromJson(Map<String, dynamic> json) => _$NftResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NftResponseToJson(this);
}

// todo: generics
@JsonSerializable()
class JsonRpcResponse {
  final String jsonrpc;
  final JsonRpcListResponse result;

  JsonRpcResponse({
    required this.jsonrpc,
    required this.result,
  });

  factory JsonRpcResponse.fromJson(Map<String, dynamic> json) => _$JsonRpcResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JsonRpcResponseToJson(this);
}

// todo: generics
@JsonSerializable()
class JsonRpcListResponse {
  final int total;
  final int limit;
  final int page;
  final List<NftResponse> items;

  JsonRpcListResponse({
    required this.total,
    required this.limit,
    required this.page,
    required this.items,
  });

  factory JsonRpcListResponse.fromJson(Map<String, dynamic> json) => _$JsonRpcListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JsonRpcListResponseToJson(this);
}
