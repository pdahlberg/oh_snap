
import 'package:oh_snap_server/src/domain/common_extensions.dart';
import 'package:oh_snap_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class QueryService {

  final Session session;

  QueryService(this.session);

  Future<User?> findUserByMatricaId(String matricaId) async {
    return _findEntityBy(
      session: session,
      table: 'app_user',
      matricaId: matricaId,
      logQuery: false,
    ).then((value) => value.map((item) => _userFromRow(item)).firstOrNull);
  }

  Future<Post?> findPostById(int postId) async {
    return _findEntityBy(
      session: session,
      table: 'post',
      id: postId,
      logQuery: false,
    ).then((value) => value.map((item) => _postFromRow(item)).firstOrNull);
  }

  Future<Post?> findPostByCaptureUrl(String captureUrl) async {
    return _findEntityBy(
      session: session,
      table: 'post',
      captureUrl: captureUrl,
    ).then((value) => value.map((item) => _postFromRow(item)).firstOrNull);
  }

  Future<List<Task>> findTaskByStatus(TaskStatus status) async {
    return _findEntityBy(
      session: session,
      table: 'task',
      status: status.index,
    ).then((value) => value.map((item) => _taskFromRow(item)).toList());
  }

  Future<Task?> findTaskById(int taskId) async {
    return _findEntityBy(
      session: session,
      table: 'task',
      id: taskId,
    ).then((value) => value.map((item) => _taskFromRow(item)).firstOrNull);
  }

  Future<List<List<dynamic>>> _findEntityBy({
    required Session session,
    required String table,
    int? id,
    String? captureUrl,
    int? type,
    int? status,
    String? matricaId,
    bool logQuery = false,
  }) async {
    var idClause = id?.let((value) => ' AND t.id = $value') ?? '';
    var captureUrlClause = captureUrl?.let((value) => " AND t.captureurl = '$value'") ?? '';
    var typeClause = type?.let((value) => ' AND t.type = $value') ?? '';
    var statusClause = status?.let((value) => ' AND t.status = $value') ?? '';
    var matricaIdClause = matricaId?.let((value) => ' AND t.matricaId = $value') ?? '';

    var query = '''
        SELECT * FROM $table t
        WHERE 1 = 1
        $idClause
        $captureUrlClause
        $typeClause
        $statusClause
        $matricaIdClause
      ''';

    if(logQuery) {
      session.log('Query: $query');
    }

    var queryResult = await session.db.query(query);

    return queryResult;
  }

  Post _postFromRow(List<dynamic> row) {
    int column = 0;
    return Post(
      id: row[column++] as int,
      title: row[column++] as String?,
      text: row[column++] as String?,
      imageUrl: row[column++] as String?,
      captureurl: row[column++] as String?,
      filename: row[column++] as String,
      shareUrl: row[column++] as String?,
      shareAltUrl: row[column++] as String?,
      address: row[column++] as String?,
      transactionId: row[column++] as String?,
      createdAt: row[column++] as DateTime,
      modifiedAt: row[column++] as DateTime,
    );
  }

  Task _taskFromRow(List<dynamic> row) {
    return Task(
      id: row[0] as int,
      postId: row[1] as int,
      type: TaskType.values[row[2] as int],
      status: TaskStatus.values[row[3] as int],
      cost: row[4] as int,
      paid: row[5] as int,
      paymentRequirement: PaymentRequirement.values[row[6] as int],
      dependsOn: row[7] as int?,
      statusMsg: row[8] as String?,
      createdAt: row[9] as DateTime,
      modifiedAt: row[10] as DateTime,
    );
  }

  User _userFromRow(List<dynamic> row) {
    int column = 0;
    return User(
      id: row[column++] as int,
      username: row[column++] as String,
      matricaId: row[column++] as String,
      matricaAccessToken: row[column++] as String,
      matricaRefreshToken: row[column++] as String,
      createdAt: row[column++] as DateTime,
      modifiedAt: row[column++] as DateTime,
    );
  }

}