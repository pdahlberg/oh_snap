import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_client/oh_snap_client.dart';

class AuthService {

  final Client _client;
  User? _user;

  AuthService(
      this._client,
  );

  AuthService.of(BuildContext context) : this(
    context.read(),
  );

  Future<Uri> authUrl() async {
    // generate random code for state
    final urlString = await _client.auth.authLink('todo_random_state_code');
    return Uri.parse(urlString);
  }

  Future<bool> isLoggedIn() async {
    return _user != null;
  }

  /*Future<Login> getLogin() async {
    var value = await _loginRepository
        .findAll()
        .then((value) => value.firstOrNull);

    return value ?? await login('login');
  }*/

}