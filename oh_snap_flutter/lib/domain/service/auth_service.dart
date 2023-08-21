import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_client/oh_snap_client.dart';
import 'package:oh_snap_flutter/domain/model/login.dart';
import 'package:oh_snap_flutter/domain/persistence/login_repository.dart';

class AuthService {

  final Client _client;
  final LoginRepository _loginRepository;
  final Random _rng = Random.secure(); // Good enough
  String? _someState; // Put in login entity

  AuthService(
    this._client,
    this._loginRepository,
  );

  AuthService.of(BuildContext context) : this(
    context.read(),
    context.read(),
  );

  Future<Uri> authUrl() async {
    _someState = _rng.nextInt(99999999).toString();
    final urlString = await _client.auth.authLink(_someState!);
    return Uri.parse(urlString);
  }

  Future<bool> isLoggedIn() async {
    final login = await _loginRepository.load();
    if(login != null) {
      // Don't need this all the time
      final user = await _client.auth.fetchUser(login.matricaId, login.accessToken);
      return user != null;
    }
    return false;
  }

  Future<User> fetchUserWithState() async {
    User? user = await _client.auth.fetchUserWithState(_someState!);
    debugPrint('Fetched user: $user');
    // Errors... who has time for that with a few minutes left...

    if(user != null) {
      final login = Login.fromUser(user);
      await _loginRepository.save(login);
    }

    return user!;
  }

  Future<User> fetchUser() async {
    final login = await _loginRepository.load();
    if(login == null) {
      throw Exception('Not logged in');
    }
    User? user = await _client.auth.fetchUser(login.matricaId, login.accessToken);
    debugPrint('Fetched user: $user');
    // Errors... who has time for that with a few minutes left...

    return user!;
  }

}