
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_flutter/features/mint/state/mint_events.dart';
import 'package:oh_snap_flutter/features/mint/state/mint_state.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';

class MintBloc extends Bloc<MintEvent, MintState> {

  final AppRouter _appRouter;

  MintBloc(
    this._appRouter,
  ) : super(const MintState()) {
    //on<LoggedOut>(_onLoggedOut);
  }

  MintBloc.of(BuildContext context) : this(
    context.read(),
  );

  /*Future<void> _onLoggedIn(LoggedIn event, Emitter<MintState> emit) async {
    final login = await _mintService.login(event.username, event.password);
    
    emit(state.copyWith(
      login: login,
    ));
    
  }*/

}
