import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_client/oh_snap_client.dart';

class AuthService {

  final Client _client;
  User? _user;
  String? _someState;

  AuthService(
      this._client,
  );

  AuthService.of(BuildContext context) : this(
    context.read(),
  );

  Future<Uri> authUrl() async {
    // generate random code for state
    _someState = DateTime.now().microsecondsSinceEpoch.toString();
    final urlString = await _client.auth.authLink(_someState!);
    return Uri.parse(urlString);
  }

  Future<bool> isLoggedIn() async {
    return _user != null;
  }

  Future<User> fetchUser() async {
    final user = await _client.auth.fetchUser(_someState!);
    // Errors... who has time for that with a few minutes left...
    return user!;
  }

}