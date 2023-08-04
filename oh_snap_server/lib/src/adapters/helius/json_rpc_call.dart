import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

//part 'json_rpc_call.g.dart';

/*
  * {
        jsonrpc: '2.0',
        id: 'my-id',
        method: 'getAssetsByOwner',
        params: {
            ownerAddress: ownerAddress,
            page: 1, // Starts at 1
            limit: 2
        },
        }*/

// For generics: https://github.com/trevorwang/retrofit.dart/issues/292
/*
@JsonSerializable(explicitToJson: true)
class JsonRpcCall<GetAs> {
  final String jsonrpc;
  final String id;
  final String method;
  @Converter()
  final List<T> params;

  JsonRpcCall({
    this.jsonrpc = '2.0',
    this.id = 'call_id',
    required this.method,
    required this.params,
  });

  factory JsonRpcCall.fromJson(Map<String, dynamic> json) => _$JsonRpcCallFromJson(json);
  Map<String, dynamic> toJson() => _$JsonRpcCallToJson(this);
}
*/