/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

class AuthState extends _i1.TableRow {
  AuthState({
    int? id,
    required this.state,
    required this.codeverifier,
    required this.codechallenge,
    required this.url,
    required this.createdAt,
    required this.modifiedAt,
  }) : super(id);

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
      createdAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['createdAt']),
      modifiedAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['modifiedAt']),
    );
  }

  static final t = AuthStateTable();

  String state;

  String codeverifier;

  String codechallenge;

  String url;

  DateTime createdAt;

  DateTime modifiedAt;

  @override
  String get tableName => 'auth_state';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state,
      'codeverifier': codeverifier,
      'codechallenge': codechallenge,
      'url': url,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'state': state,
      'codeverifier': codeverifier,
      'codechallenge': codechallenge,
      'url': url,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'state': state,
      'codeverifier': codeverifier,
      'codechallenge': codechallenge,
      'url': url,
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
      case 'state':
        state = value;
        return;
      case 'codeverifier':
        codeverifier = value;
        return;
      case 'codechallenge':
        codechallenge = value;
        return;
      case 'url':
        url = value;
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

  static Future<List<AuthState>> find(
    _i1.Session session, {
    AuthStateExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<AuthState>(
      where: where != null ? where(AuthState.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<AuthState?> findSingleRow(
    _i1.Session session, {
    AuthStateExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<AuthState>(
      where: where != null ? where(AuthState.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<AuthState?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<AuthState>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required AuthStateExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AuthState>(
      where: where(AuthState.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    AuthState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    AuthState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    AuthState row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    AuthStateExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AuthState>(
      where: where != null ? where(AuthState.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef AuthStateExpressionBuilder = _i1.Expression Function(AuthStateTable);

class AuthStateTable extends _i1.Table {
  AuthStateTable() : super(tableName: 'auth_state');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final state = _i1.ColumnString('state');

  final codeverifier = _i1.ColumnString('codeverifier');

  final codechallenge = _i1.ColumnString('codechallenge');

  final url = _i1.ColumnString('url');

  final createdAt = _i1.ColumnDateTime('createdAt');

  final modifiedAt = _i1.ColumnDateTime('modifiedAt');

  @override
  List<_i1.Column> get columns => [
        id,
        state,
        codeverifier,
        codechallenge,
        url,
        createdAt,
        modifiedAt,
      ];
}

@Deprecated('Use AuthStateTable.t instead.')
AuthStateTable tAuthState = AuthStateTable();
