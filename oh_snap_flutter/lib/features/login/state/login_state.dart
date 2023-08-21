
import 'package:equatable/equatable.dart';
import 'package:oh_snap_client/oh_snap_client.dart';

class LoginState extends Equatable {

  final Uri? authUrl;
  final User? user;

  const LoginState({
    this.authUrl,
    this.user,
  });

  LoginState copyWith({
    Uri? authUrl,
    User? user,
  }) {
    return LoginState(
      authUrl: authUrl ?? this.authUrl,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [authUrl, user];

}


