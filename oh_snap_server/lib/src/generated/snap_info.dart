/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class SnapInfo extends _i1.SerializableEntity {
  SnapInfo({required this.imageUrl});

  factory SnapInfo.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return SnapInfo(
        imageUrl: serializationManager
            .deserialize<String>(jsonSerialization['imageUrl']));
  }

  String imageUrl;

  @override
  Map<String, dynamic> toJson() {
    return {'imageUrl': imageUrl};
  }

  @override
  Map<String, dynamic> allToJson() {
    return {'imageUrl': imageUrl};
  }
}
