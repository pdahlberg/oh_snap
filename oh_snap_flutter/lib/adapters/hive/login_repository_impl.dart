
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oh_snap_flutter/adapters/hive/entity/login_entity.dart';
import 'package:oh_snap_flutter/adapters/hive/persistence.dart';
import 'package:oh_snap_flutter/domain/model/login.dart';
import 'package:oh_snap_flutter/domain/persistence/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {

  final PersistenceImpl _persistence;
  Future<Box<LoginEntity>> get _db => _persistence.login;

  LoginRepositoryImpl(
      this._persistence,
  );

  LoginRepositoryImpl.of(BuildContext context) : this(
    context.read(),
  );

  @override
  Future<Login> save(Login login) async {
    await clear(); // Remember this...

    debugPrint('LoginRepositoryImpl => save()');
    await (await _db).put(
        login.matricaId,
        mapToEntity(login),
    );
    return login;
  }

  @override
  Future<bool> clear() async {
    debugPrint('LoginRepositoryImpl => clear()');
    await (await _db).clear();
    return true;
  }

  @override
  Future<Login?> load() async => (await _db).values
      .map(mapToDomain)
      .toList()
      .firstOrNull;

  Login mapToDomain(LoginEntity entity) => Login(
    entity.matricaId,
    entity.accessToken,
  );

  LoginEntity mapToEntity(Login login) => LoginEntity(
    matricaId: login.matricaId,
    accessToken: login.accessToken,
  );

}