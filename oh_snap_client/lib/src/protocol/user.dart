/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class User extends _i1.SerializableEntity {
  User({
    this.id,
    required this.username,
    required this.matricaid,
    required this.matricaaccesstoken,
    required this.matricaRefreshToken,
    required this.credits,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory User.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return User(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      username: serializationManager
          .deserialize<String>(jsonSerialization['username']),
      matricaid: serializationManager
          .deserialize<String>(jsonSerialization['matricaid']),
      matricaaccesstoken: serializationManager
          .deserialize<String>(jsonSerialization['matricaaccesstoken']),
      matricaRefreshToken: serializationManager
          .deserialize<String>(jsonSerialization['matricaRefreshToken']),
      credits:
          serializationManager.deserialize<int>(jsonSerialization['credits']),
      createdAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['createdAt']),
      modifiedAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['modifiedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String username;

  String matricaid;

  String matricaaccesstoken;

  String matricaRefreshToken;

  int credits;

  DateTime createdAt;

  DateTime modifiedAt;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'matricaid': matricaid,
      'matricaaccesstoken': matricaaccesstoken,
      'matricaRefreshToken': matricaRefreshToken,
      'credits': credits,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }
}
