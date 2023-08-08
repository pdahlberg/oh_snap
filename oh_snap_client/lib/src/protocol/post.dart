/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

class Post extends _i1.SerializableEntity {
  Post({
    this.id,
    this.url,
    this.text,
    this.tasks,
    this.address,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory Post.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Post(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      url: serializationManager.deserialize<String?>(jsonSerialization['url']),
      text:
          serializationManager.deserialize<String?>(jsonSerialization['text']),
      tasks: serializationManager
          .deserialize<List<_i2.Task>?>(jsonSerialization['tasks']),
      address: serializationManager
          .deserialize<String?>(jsonSerialization['address']),
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

  String? url;

  String? text;

  List<_i2.Task>? tasks;

  String? address;

  DateTime createdAt;

  DateTime modifiedAt;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'text': text,
      'tasks': tasks,
      'address': address,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }
}
