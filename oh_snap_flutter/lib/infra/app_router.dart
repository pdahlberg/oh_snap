import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oh_snap_flutter/domain/service/auth_service.dart';
import 'package:oh_snap_flutter/domain/service/time_service.dart';
import 'package:oh_snap_flutter/features/annotate/view/annotate_page.dart';
import 'package:oh_snap_flutter/features/capture/view/snap_page.dart';
import 'package:oh_snap_flutter/features/login/view/login_page.dart';
import 'package:oh_snap_flutter/features/mint/view/mint_page.dart';
import 'package:oh_snap_flutter/view/main_page.dart';

class AppRouter {

  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  final TimeService timeService;
  final AuthService authService;
  GoRouter get router => _goRouter;

  AppRouter(
    this.timeService,
    this.authService,
  );

  AppRouter.of(BuildContext context) : this(
    context.read(),
    context.read(),
  );

  late final GoRouter _goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: SnapPage.path,
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) async {
      debugPrint('Requested path: ${state.path}');
      if(await authService.isLoggedIn()) {
        debugPrint('Logged in with path: ${state.path}');
        /*if(state.path == MainPage.path || state.path == null) {
          return UserAssetListPage.path;
        } else {
          debugPrint('Navigating to ${state.path}');
          return state.path;
        }*/
        return null;
      } else {
        return LoginPage.path;
      }
    },
    routes: <RouteBase>[
      GoRoute(
        path: SnapPage.path,
        builder: (BuildContext context, GoRouterState state) {
          return const SnapPage();
        },
      ),
      GoRoute(
        path: MintPage.path,
        builder: (BuildContext context, GoRouterState state) {
          return const MintPage();
        },
      ),
      GoRoute(
        path: AnnotatePage.path,
        builder: (BuildContext context, GoRouterState state) {
          return const AnnotatePage();
        },
      ),
      GoRoute(
        path: LoginPage.path,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
    ],
    //errorBuilder: (context, state) => ErrorPage(error: state.error.toString())
  );
}



