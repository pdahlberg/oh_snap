import 'package:oh_snap_flutter/domain/model/login.dart';

abstract class LoginRepository {

  Future<Login> save(Login login);

  Future<bool> clear();

  Future<Login?> load();

}