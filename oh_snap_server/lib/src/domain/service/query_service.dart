
import 'package:oh_snap_server/src/domain/common_extensions.dart';
import 'package:oh_snap_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class QueryService {

  final Session session;

  QueryService(this.session);

  Future<Post?> findPostById(int postId) async {
    return _findEntityBy(
      session: session,
      table: 'post',
      id: postId,
    ).then((value) => value.map((item) => _postFromRow(item)).firstOrNull);
  }

  Future<Post?> findPostByCaptureUrl(String captureUrl) async {
    return _findEntityBy(
      session: session,
      table: 'post',
      captureUrl: captureUrl,
    ).then((value) => value.map((item) => _postFromRow(item)).firstOrNull);
  }

  Future<List<Task>> findTaskByTypeAndStatus(TaskType type, TaskStatus status) async {
    return _findEntityBy(
      session: session,
      table: 'task',
      type: type.index,
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
    bool logQuery = false,
  }) async {
    var idClause = id?.let((value) => ' AND id = $value') ?? '';
    var captureUrlClause = id?.let((value) => " AND captureUrl = '$value'") ?? '';
    var typeClause = type?.let((value) => ' AND type = $value') ?? '';
    var statusClause = status?.let((value) => ' AND status = $value') ?? '';

    var query = '''
        SELECT * FROM $table 
        WHERE 1 = 1
        $idClause
        $captureUrlClause
        $typeClause
        $statusClause
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
      captureUrl: row[column++] as String?,
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

}