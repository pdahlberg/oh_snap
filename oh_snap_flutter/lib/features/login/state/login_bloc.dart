
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_client/oh_snap_client.dart';
import 'package:oh_snap_flutter/domain/service/auth_service.dart';
import 'package:oh_snap_flutter/features/login/state/login_events.dart';
import 'package:oh_snap_flutter/features/login/state/login_state.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AppRouter _appRouter;
  final Client _client;
  final AuthService _authService;

  LoginBloc(
    this._appRouter,
    this._client,
    this._authService,
  ) : super(const LoginState()) {
    on<FetchAuthUrl>(_onFetchAuthUrl);
    on<SyncUser>(_onSyncUser);
  }

  LoginBloc.of(BuildContext context) : this(
    context.read(),
    context.read(),
    context.read(),
  );

  Future<void> _onFetchAuthUrl(FetchAuthUrl event, Emitter<LoginState> emit) async {
    final url = await _authService.authUrl();
    debugPrint('LoginBloc: authUrl: $url');

    emit(state.copyWith(
      authUrl: url,
    ));
  }

  Future<void> _onSyncUser(SyncUser event, Emitter<LoginState> emit) async {
    final user = await _authService.fetchUser();

    emit(state.copyWith(
      user: user,
    ));
  }

}
