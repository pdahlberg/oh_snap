
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override List<Object?> get props => [];
}

class FetchAuthUrl extends LoginEvent {}
class SyncUser extends LoginEvent {}



