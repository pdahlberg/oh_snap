/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

class AuthState extends _i1.SerializableEntity {
  AuthState({
    this.id,
    required this.state,
    required this.codeverifier,
    required this.codechallenge,
    required this.url,
    this.matricaid,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory AuthState.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return AuthState(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      state:
          serializationManager.deserialize<String>(jsonSerialization['state']),
      codeverifier: serializationManager
          .deserialize<String>(jsonSerialization['codeverifier']),
      codechallenge: serializationManager
          .deserialize<String>(jsonSerialization['codechallenge']),
      url: serializationManager.deserialize<String>(jsonSerialization['url']),
      matricaid: serializationManager
          .deserialize<String?>(jsonSerialization['matricaid']),
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

  String state;

  String codeverifier;

  String codechallenge;

  String url;

  String? matricaid;

  DateTime createdAt;

  DateTime modifiedAt;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state,
      'codeverifier': codeverifier,
      'codechallenge': codechallenge,
      'url': url,
      'matricaid': matricaid,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }
}
