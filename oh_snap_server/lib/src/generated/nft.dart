/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class Nft extends _i1.SerializableEntity {
  Nft({
    required this.name,
    required this.imageUrl,
  });

  factory Nft.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Nft(
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      imageUrl: serializationManager
          .deserialize<String>(jsonSerialization['imageUrl']),
    );
  }

  String name;

  String imageUrl;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
