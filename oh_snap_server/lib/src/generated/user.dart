/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class User extends _i1.SerializableEntity {
  User({
    required this.id,
    required this.username,
    required this.matricaId,
    required this.matricaAccessToken,
    required this.credits,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory User.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return User(
      id: serializationManager.deserialize<int>(jsonSerialization['id']),
      username: serializationManager
          .deserialize<String>(jsonSerialization['username']),
      matricaId: serializationManager
          .deserialize<String>(jsonSerialization['matricaId']),
      matricaAccessToken: serializationManager
          .deserialize<String>(jsonSerialization['matricaAccessToken']),
      credits:
          serializationManager.deserialize<int>(jsonSerialization['credits']),
      createdAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['createdAt']),
      modifiedAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['modifiedAt']),
    );
  }

  int id;

  String username;

  String matricaId;

  String matricaAccessToken;

  int credits;

  DateTime createdAt;

  DateTime modifiedAt;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'matricaId': matricaId,
      'matricaAccessToken': matricaAccessToken,
      'credits': credits,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'username': username,
      'matricaId': matricaId,
      'matricaAccessToken': matricaAccessToken,
      'credits': credits,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }
}
