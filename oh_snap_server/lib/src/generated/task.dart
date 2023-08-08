/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'protocol.dart' as _i2;

class Task extends _i1.TableRow {
  Task({
    int? id,
    required this.postId,
    required this.type,
    required this.cost,
    required this.paid,
    required this.paymentRequirement,
    this.dependsOn,
    required this.createdAt,
    required this.modifiedAt,
  }) : super(id);

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
      cost: serializationManager.deserialize<int>(jsonSerialization['cost']),
      paid: serializationManager.deserialize<int>(jsonSerialization['paid']),
      paymentRequirement:
          serializationManager.deserialize<_i2.PaymentRequirement>(
              jsonSerialization['paymentRequirement']),
      dependsOn: serializationManager
          .deserialize<int?>(jsonSerialization['dependsOn']),
      createdAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['createdAt']),
      modifiedAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['modifiedAt']),
    );
  }

  static final t = TaskTable();

  int postId;

  _i2.TaskType type;

  int cost;

  int paid;

  _i2.PaymentRequirement paymentRequirement;

  int? dependsOn;

  DateTime createdAt;

  DateTime modifiedAt;

  @override
  String get tableName => 'task';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'type': type,
      'cost': cost,
      'paid': paid,
      'paymentRequirement': paymentRequirement,
      'dependsOn': dependsOn,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'postId': postId,
      'type': type,
      'cost': cost,
      'paid': paid,
      'paymentRequirement': paymentRequirement,
      'dependsOn': dependsOn,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'postId': postId,
      'type': type,
      'cost': cost,
      'paid': paid,
      'paymentRequirement': paymentRequirement,
      'dependsOn': dependsOn,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }

  @override
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'postId':
        postId = value;
        return;
      case 'type':
        type = value;
        return;
      case 'cost':
        cost = value;
        return;
      case 'paid':
        paid = value;
        return;
      case 'paymentRequirement':
        paymentRequirement = value;
        return;
      case 'dependsOn':
        dependsOn = value;
        return;
      case 'createdAt':
        createdAt = value;
        return;
      case 'modifiedAt':
        modifiedAt = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  static Future<List<Task>> find(
    _i1.Session session, {
    TaskExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Task>(
      where: where != null ? where(Task.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Task?> findSingleRow(
    _i1.Session session, {
    TaskExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Task>(
      where: where != null ? where(Task.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Task?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Task>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required TaskExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Task>(
      where: where(Task.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Task row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Task row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Task row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    TaskExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Task>(
      where: where != null ? where(Task.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef TaskExpressionBuilder = _i1.Expression Function(TaskTable);

class TaskTable extends _i1.Table {
  TaskTable() : super(tableName: 'task');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final postId = _i1.ColumnInt('postId');

  final type = _i1.ColumnEnum<_i2.TaskType>('type');

  final cost = _i1.ColumnInt('cost');

  final paid = _i1.ColumnInt('paid');

  final paymentRequirement =
      _i1.ColumnEnum<_i2.PaymentRequirement>('paymentRequirement');

  final dependsOn = _i1.ColumnInt('dependsOn');

  final createdAt = _i1.ColumnDateTime('createdAt');

  final modifiedAt = _i1.ColumnDateTime('modifiedAt');

  @override
  List<_i1.Column> get columns => [
        id,
        postId,
        type,
        cost,
        paid,
        paymentRequirement,
        dependsOn,
        createdAt,
        modifiedAt,
      ];
}

@Deprecated('Use TaskTable.t instead.')
TaskTable tTask = TaskTable();
