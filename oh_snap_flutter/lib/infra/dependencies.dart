import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_client/oh_snap_client.dart';
import 'package:oh_snap_flutter/domain/service/time_service.dart';
import 'package:oh_snap_flutter/domain/state/snap_form_bloc.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class Dependencies {

  static List<Provider> common() => [
    Provider<TimeService>(create: (_) => TimeService()),
    Provider<Client>(create: (_) => Client('http://localhost:8080/')..connectivityMonitor = FlutterConnectivityMonitor()),
    Provider<AppRouter>(create: AppRouter.of),
  ];

  static List<BlocProvider> blocs() => [
    BlocProvider<SnapFormBloc>(create: (context) => SnapFormBloc.of(context)),

  ];

}
