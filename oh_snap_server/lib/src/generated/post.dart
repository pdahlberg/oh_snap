/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'protocol.dart' as _i2;

class Post extends _i1.TableRow {
  Post({
    int? id,
    this.title,
    this.text,
    this.imageUrl,
    this.captureurl,
    required this.filename,
    this.shareUrl,
    this.shareAltUrl,
    this.tasks,
    this.address,
    this.transactionId,
    required this.createdAt,
    required this.modifiedAt,
  }) : super(id);

  factory Post.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Post(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      title:
          serializationManager.deserialize<String?>(jsonSerialization['title']),
      text:
          serializationManager.deserialize<String?>(jsonSerialization['text']),
      imageUrl: serializationManager
          .deserialize<String?>(jsonSerialization['imageUrl']),
      captureurl: serializationManager
          .deserialize<String?>(jsonSerialization['captureurl']),
      filename: serializationManager
          .deserialize<String>(jsonSerialization['filename']),
      shareUrl: serializationManager
          .deserialize<String?>(jsonSerialization['shareUrl']),
      shareAltUrl: serializationManager
          .deserialize<String?>(jsonSerialization['shareAltUrl']),
      tasks: serializationManager
          .deserialize<List<_i2.Task>?>(jsonSerialization['tasks']),
      address: serializationManager
          .deserialize<String?>(jsonSerialization['address']),
      transactionId: serializationManager
          .deserialize<String?>(jsonSerialization['transactionId']),
      createdAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['createdAt']),
      modifiedAt: serializationManager
          .deserialize<DateTime>(jsonSerialization['modifiedAt']),
    );
  }

  static final t = PostTable();

  String? title;

  String? text;

  String? imageUrl;

  String? captureurl;

  String filename;

  String? shareUrl;

  String? shareAltUrl;

  List<_i2.Task>? tasks;

  String? address;

  String? transactionId;

  DateTime createdAt;

  DateTime modifiedAt;

  @override
  String get tableName => 'post';
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'imageUrl': imageUrl,
      'captureurl': captureurl,
      'filename': filename,
      'shareUrl': shareUrl,
      'shareAltUrl': shareAltUrl,
      'tasks': tasks,
      'address': address,
      'transactionId': transactionId,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }

  @override
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'imageUrl': imageUrl,
      'captureurl': captureurl,
      'filename': filename,
      'shareUrl': shareUrl,
      'shareAltUrl': shareAltUrl,
      'address': address,
      'transactionId': transactionId,
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'imageUrl': imageUrl,
      'captureurl': captureurl,
      'filename': filename,
      'shareUrl': shareUrl,
      'shareAltUrl': shareAltUrl,
      'tasks': tasks,
      'address': address,
      'transactionId': transactionId,
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
      case 'title':
        title = value;
        return;
      case 'text':
        text = value;
        return;
      case 'imageUrl':
        imageUrl = value;
        return;
      case 'captureurl':
        captureurl = value;
        return;
      case 'filename':
        filename = value;
        return;
      case 'shareUrl':
        shareUrl = value;
        return;
      case 'shareAltUrl':
        shareAltUrl = value;
        return;
      case 'address':
        address = value;
        return;
      case 'transactionId':
        transactionId = value;
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

  static Future<List<Post>> find(
    _i1.Session session, {
    PostExpressionBuilder? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Post>(
      where: where != null ? where(Post.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Post?> findSingleRow(
    _i1.Session session, {
    PostExpressionBuilder? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Post>(
      where: where != null ? where(Post.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static Future<Post?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Post>(id);
  }

  static Future<int> delete(
    _i1.Session session, {
    required PostExpressionBuilder where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Post>(
      where: where(Post.t),
      transaction: transaction,
    );
  }

  static Future<bool> deleteRow(
    _i1.Session session,
    Post row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  static Future<bool> update(
    _i1.Session session,
    Post row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  static Future<void> insert(
    _i1.Session session,
    Post row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  static Future<int> count(
    _i1.Session session, {
    PostExpressionBuilder? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Post>(
      where: where != null ? where(Post.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }
}

typedef PostExpressionBuilder = _i1.Expression Function(PostTable);

class PostTable extends _i1.Table {
  PostTable() : super(tableName: 'post');

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  final id = _i1.ColumnInt('id');

  final title = _i1.ColumnString('title');

  final text = _i1.ColumnString('text');

  final imageUrl = _i1.ColumnString('imageUrl');

  final captureurl = _i1.ColumnString('captureurl');

  final filename = _i1.ColumnString('filename');

  final shareUrl = _i1.ColumnString('shareUrl');

  final shareAltUrl = _i1.ColumnString('shareAltUrl');

  final address = _i1.ColumnString('address');

  final transactionId = _i1.ColumnString('transactionId');

  final createdAt = _i1.ColumnDateTime('createdAt');

  final modifiedAt = _i1.ColumnDateTime('modifiedAt');

  @override
  List<_i1.Column> get columns => [
        id,
        title,
        text,
        imageUrl,
        captureurl,
        filename,
        shareUrl,
        shareAltUrl,
        address,
        transactionId,
        createdAt,
        modifiedAt,
      ];
}

@Deprecated('Use PostTable.t instead.')
PostTable tPost = PostTable();
