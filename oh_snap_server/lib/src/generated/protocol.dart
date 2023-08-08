/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'nft.dart' as _i3;
import 'nft_list.dart' as _i4;
import 'payment_requirement.dart' as _i5;
import 'post.dart' as _i6;
import 'snap_info.dart' as _i7;
import 'task.dart' as _i8;
import 'task_type.dart' as _i9;
import 'protocol.dart' as _i10;
export 'nft.dart';
export 'nft_list.dart';
export 'payment_requirement.dart';
export 'post.dart';
export 'snap_info.dart';
export 'task.dart';
export 'task_type.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  static final targetDatabaseDefinition = _i2.DatabaseDefinition(tables: [
    _i2.TableDefinition(
      name: 'post',
      schema: 'public',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'post_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'captureUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'shareUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'shareAltUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'address',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'post_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'task',
      schema: 'public',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'task_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'postId',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'protocol:TaskType',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'paid',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'paymentRequirement',
          columnType: _i2.ColumnType.integer,
          isNullable: false,
          dartType: 'protocol:PaymentRequirement',
        ),
        _i2.ColumnDefinition(
          name: 'dependsOn',
          columnType: _i2.ColumnType.integer,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'modifiedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'task_fk_0',
          columns: ['postId'],
          referenceTable: 'post',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: null,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'task_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    ..._i2.Protocol.targetDatabaseDefinition.tables,
  ]);

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i3.Nft) {
      return _i3.Nft.fromJson(data, this) as T;
    }
    if (t == _i4.NftList) {
      return _i4.NftList.fromJson(data, this) as T;
    }
    if (t == _i5.PaymentRequirement) {
      return _i5.PaymentRequirement.fromJson(data) as T;
    }
    if (t == _i6.Post) {
      return _i6.Post.fromJson(data, this) as T;
    }
    if (t == _i7.SnapInfo) {
      return _i7.SnapInfo.fromJson(data, this) as T;
    }
    if (t == _i8.Task) {
      return _i8.Task.fromJson(data, this) as T;
    }
    if (t == _i9.TaskType) {
      return _i9.TaskType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.Nft?>()) {
      return (data != null ? _i3.Nft.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.NftList?>()) {
      return (data != null ? _i4.NftList.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i5.PaymentRequirement?>()) {
      return (data != null ? _i5.PaymentRequirement.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Post?>()) {
      return (data != null ? _i6.Post.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i7.SnapInfo?>()) {
      return (data != null ? _i7.SnapInfo.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i8.Task?>()) {
      return (data != null ? _i8.Task.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i9.TaskType?>()) {
      return (data != null ? _i9.TaskType.fromJson(data) : null) as T;
    }
    if (t == List<_i10.Nft>) {
      return (data as List).map((e) => deserialize<_i10.Nft>(e)).toList()
          as dynamic;
    }
    if (t == _i1.getType<List<_i10.Task>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i10.Task>(e)).toList()
          : null) as dynamic;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    if (data is _i3.Nft) {
      return 'Nft';
    }
    if (data is _i4.NftList) {
      return 'NftList';
    }
    if (data is _i5.PaymentRequirement) {
      return 'PaymentRequirement';
    }
    if (data is _i6.Post) {
      return 'Post';
    }
    if (data is _i7.SnapInfo) {
      return 'SnapInfo';
    }
    if (data is _i8.Task) {
      return 'Task';
    }
    if (data is _i9.TaskType) {
      return 'TaskType';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Nft') {
      return deserialize<_i3.Nft>(data['data']);
    }
    if (data['className'] == 'NftList') {
      return deserialize<_i4.NftList>(data['data']);
    }
    if (data['className'] == 'PaymentRequirement') {
      return deserialize<_i5.PaymentRequirement>(data['data']);
    }
    if (data['className'] == 'Post') {
      return deserialize<_i6.Post>(data['data']);
    }
    if (data['className'] == 'SnapInfo') {
      return deserialize<_i7.SnapInfo>(data['data']);
    }
    if (data['className'] == 'Task') {
      return deserialize<_i8.Task>(data['data']);
    }
    if (data['className'] == 'TaskType') {
      return deserialize<_i9.TaskType>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.Post:
        return _i6.Post.t;
      case _i8.Task:
        return _i8.Task.t;
    }
    return null;
  }

  @override
  _i2.DatabaseDefinition getTargetDatabaseDefinition() =>
      targetDatabaseDefinition;
}
