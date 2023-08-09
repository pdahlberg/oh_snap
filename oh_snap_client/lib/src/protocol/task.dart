/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'protocol.dart' as _i2;

class Task extends _i1.SerializableEntity {
  Task({
    this.id,
    required this.postId,
    required this.type,
    required this.status,
    required this.cost,
    required this.paid,
    required this.paymentRequirement,
    this.dependsOn,
    this.statusMsg,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory Task.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Task(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      postId:
          serializationManager.deserialize<int>(jsonSerialization['postId']),
      type: serializationManager
          .deserialize<_i2.TaskType>(jsonSerialization['type']),
      status: serializationManager
          .deserialize<_i2.TaskStatus>(jsonSerialization['status']),
      cost: serializationManager.deserialize<int>(jsonSerialization['cost']),
      paid: serializationManager.deserialize<int>(jsonSerialization['paid']),
      paymentRequirement:
          serializationManager.deserialize<_i2.PaymentRequirement>(
              jsonSerialization['paymentRequirement']),
      dependsOn: serializationManager
          .deserialize<int?>(jsonSerialization['dependsOn']),
      statusMsg: serializationManager
          .deserialize<String?>(jsonSerialization['statusMsg']),
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

  int postId;

  _i2.TaskType type;

  _i2.TaskStatus status;

  int cost;

  int paid;

  _i2.PaymentRequirement paymentRequirement;

  int? dependsOn;

  String? statusMsg;

  DateTime createdAt;

  DateTime modifiedAt;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'type': type,
      'status': status,
      'cost': cost,
      'paid': paid,
      'paymentRequirement': paymentRequirement,
      'dependsOn': dependsOn,
      'statusMsg': statusMsg,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }
}
