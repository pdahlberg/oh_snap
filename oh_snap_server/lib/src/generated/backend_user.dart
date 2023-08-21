/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class BackendUser extends _i1.TableRow {
  BackendUser({
    int? id,
    required this.username,
    required this.matricaid,
    required this.matricaaccesstoken,
    required this.matricaRefreshToken,
    required this.credits,
    required this.createdAt,
    required this.modifiedAt,
  }) : super(id);

  factory BackendUser.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return BackendUser(
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

  static final t = BackendUserTable();

  String username;

  String matricaid;

  String matricaaccesstoken;

  String matricaRefreshToken;

  int credits;

  DateTime createdAt;

  DateTime modifiedAt;

  @override
  String get tableName => 'backend_user';
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

  @override
  Map<String, dynamic> toJsonForDatabase() {
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

  @override
  Map<String, dynamic> allToJson() {
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

  @override
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'username':
        username = value;
        return;
      case 'matricaid':
        matricaid = value;
        return;
      case 'matricaaccesstoken':
        matricaaccesstoken = value;
        return;
      case 'matricaRefreshToken':
        matricaRefreshToken = value;
        return;
      case 'credits':
        credits = value;
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

  static Future<List<BackendUser>> find(
    _i1.Session session, {
    BackendUserExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BackendUser>(
      where: where != null ? where(BackendUser.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<BackendUser?> findSingleRow(
    _i1.Session session, {
    BackendUserExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<BackendUser>(
      where: where != null ? where(BackendUser.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<BackendUser?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<BackendUser>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required BackendUserExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BackendUser>(
      where: where(BackendUser.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    BackendUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    BackendUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    BackendUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    BackendUserExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BackendUser>(
      where: where != null ? where(BackendUser.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef BackendUserExpressionBuilder = _i1.Expression Function(
    BackendUserTable);

class BackendUserTable extends _i1.Table {
  BackendUserTable() : super(tableName: 'backend_user');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final username = _i1.ColumnString('username');

  final matricaid = _i1.ColumnString('matricaid');

  final matricaaccesstoken = _i1.ColumnString('matricaaccesstoken');

  final matricaRefreshToken = _i1.ColumnString('matricaRefreshToken');

  final credits = _i1.ColumnInt('credits');

  final createdAt = _i1.ColumnDateTime('createdAt');

  final modifiedAt = _i1.ColumnDateTime('modifiedAt');

  @override
  List<_i1.Column> get columns => [
        id,
        username,
        matricaid,
        matricaaccesstoken,
        matricaRefreshToken,
        credits,
        createdAt,
        modifiedAt,
      ];
}

@Deprecated('Use BackendUserTable.t instead.')
BackendUserTable tBackendUser = BackendUserTable();
