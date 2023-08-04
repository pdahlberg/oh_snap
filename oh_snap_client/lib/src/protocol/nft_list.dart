/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

class NftList extends _i1.SerializableEntity {
  NftList({
    required this.items,
    required this.total,
    required this.page,
  });

  factory NftList.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return NftList(
      items: serializationManager
          .deserialize<List<_i2.Nft>>(jsonSerialization['items']),
      total: serializationManager.deserialize<int>(jsonSerialization['total']),
      page: serializationManager.deserialize<int>(jsonSerialization['page']),
    );
  }

  List<_i2.Nft> items;

  int total;

  int page;

  @override
  Map<String, dynamic> toJson() {
    return {
      'items': items,
      'total': total,
      'page': page,
    };
  }
}
