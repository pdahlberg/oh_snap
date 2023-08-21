
import 'package:oh_snap_server/src/domain/common_extensions.dart';
import 'package:oh_snap_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class QueryService {

  final Session session;

  QueryService(this.session);

  Future<AuthState?> findAuthStateByState(String state) async {
    return _findEntityBy(
      session: session,
      table: 'auth_state',
      state: state,
      logQuery: false,
    ).then((value) => value.map((item) => _authStateFromRow(item)).firstOrNull);
  }

  Future<BackendUser?> findUserByMatricaId(String matricaId, { String? accessToken }) async {
    return _findEntityBy(
      session: session,
      table: 'backend_user',
      matricaId: matricaId,
      accessToken: accessToken,
      logQuery: false,
    ).then((value) => value.map((item) => _backendUserFromRow(item)).firstOrNull);
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
    String? state,
    String? accessToken,
    bool logQuery = false,
  }) async {
    var idClause = id?.let((value) => ' AND t.id = $value') ?? '';
    var captureUrlClause = captureUrl?.let((value) => " AND t.captureurl = '$value'") ?? '';
    var typeClause = type?.let((value) => ' AND t.type = $value') ?? '';
    var statusClause = status?.let((value) => ' AND t.status = $value') ?? '';
    var matricaIdClause = matricaId?.let((value) => " AND t.matricaid = '$value'") ?? '';
    var stateClause = state?.let((value) => " AND t.state = '$value'") ?? '';
    var accessTokenClause = accessToken?.let((value) => " AND t.matricaaccesstoken = '$value'") ?? '';

    var query = '''
        SELECT * FROM $table t
        WHERE 1 = 1
        $idClause
        $captureUrlClause
        $typeClause
        $statusClause
        $matricaIdClause
        $stateClause
        $accessTokenClause
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
      userId: row[column++] as int,
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

  BackendUser _backendUserFromRow(List<dynamic> row) {
    int column = 0;
    return BackendUser(
      id: row[column++] as int,
      username: row[column++] as String,
      matricaid: row[column++] as String,
      matricaaccesstoken: row[column++] as String,
      matricaRefreshToken: row[column++] as String,
      credits: row[column++] as int,
      createdAt: row[column++] as DateTime,
      modifiedAt: row[column++] as DateTime,
    );
  }

  AuthState _authStateFromRow(List<dynamic> row) {
    int column = 0;
    return AuthState(
      id: row[column++] as int,
      state: row[column++] as String,
      codeverifier: row[column++] as String,
      codechallenge: row[column++] as String,
      url: row[column++] as String,
      matricaid: row[column++] as String?,
      createdAt: row[column++] as DateTime,
      modifiedAt: row[column++] as DateTime,
    );
  }

  // todo: move to a sensible place
  User backendUserToUser(BackendUser backendUser) {
    return User(
      id: backendUser.id!,
      username: backendUser.username,
      matricaId: backendUser.matricaid,
      matricaAccessToken: backendUser.matricaaccesstoken,
      credits: backendUser.credits,
      createdAt: backendUser.createdAt,
      modifiedAt: backendUser.modifiedAt,
    );
  }

}