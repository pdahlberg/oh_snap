import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_client/oh_snap_client.dart';
import 'package:oh_snap_flutter/adapters/hive/login_repository_impl.dart';
import 'package:oh_snap_flutter/adapters/hive/persistence.dart';
import 'package:oh_snap_flutter/domain/persistence/login_repository.dart';
import 'package:oh_snap_flutter/domain/service/auth_service.dart';
import 'package:oh_snap_flutter/domain/service/time_service.dart';
import 'package:oh_snap_flutter/features/annotate/state/annotate_bloc.dart';
import 'package:oh_snap_flutter/features/capture/state/snap_form_bloc.dart';
import 'package:oh_snap_flutter/features/login/state/login_bloc.dart';
import 'package:oh_snap_flutter/features/mint/state/mint_bloc.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class Dependencies {

  static const baseUrl = 'https://api.ohsnap.app/';
  //static const baseUrl = 'http://localhost:8080/';

  static List<Provider> common() => [
    Provider<TimeService>(create: (_) => TimeService()),
    Provider<PersistenceImpl>(create: (_) => PersistenceImpl()..init()),
    Provider<Client>(create: (_) => Client(baseUrl)..connectivityMonitor = FlutterConnectivityMonitor()),
    Provider<LoginRepository>(create: LoginRepositoryImpl.of),
    Provider<AuthService>(create: AuthService.of),
    Provider<AppRouter>(create: AppRouter.of),
  ];

  /*static List<ProxyProvider> commonWithDependency() => [
    ProxyProvider<Client, SessionManager>(update: (_, client, instance) => SessionManager(
      caller: client.modules.auth,
    )..initialize()),
  ];*/

  static List<BlocProvider> blocs() => [
    BlocProvider<SnapFormBloc>(create: (context) => SnapFormBloc.of(context)),
    BlocProvider<MintBloc>(create: (context) => MintBloc.of(context)),
    BlocProvider<AnnotateBloc>(create: (context) => AnnotateBloc.of(context)),
    BlocProvider<LoginBloc>(create: (context) => LoginBloc.of(context)),
  ];

}
