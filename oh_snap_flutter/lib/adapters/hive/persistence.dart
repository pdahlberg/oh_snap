import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:oh_snap_flutter/adapters/hive/entity/login_entity.dart';

abstract class Persistence {
  Future<Box<LoginEntity>> get login;
}

class PersistenceImpl implements Persistence {

  static const _dbDir = "db";
  static const _loginBox = 'login';
  Completer<PersistenceImpl>? completer;

  Future<PersistenceImpl> init() {
    if(completer == null) {
      completer = Completer();
      Future<void>.delayed(const Duration(seconds: 1)).then((value) async {
        await Hive.initFlutter(_dbDir);
        registerAdapters();
        completer!.complete(this);
      });
    }

    return completer!.future;
  }

  void registerAdapters() {
    Hive.registerAdapter(LoginEntityAdapter());
  }

  Future<PersistenceImpl> get db async => init();

  @override Future<Box<LoginEntity>> get login => db.then((value) => Hive.openBox(_loginBox));

}