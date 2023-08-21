import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_flutter/features/login/state/login_bloc.dart';
import 'package:oh_snap_flutter/features/login/state/login_events.dart';
import 'package:oh_snap_flutter/features/login/state/login_state.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';
import 'package:oh_snap_flutter/infra/extension_methods.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {

  static const String label = 'Login';
  static const String path = '/login';

  const LoginPage({ super.key });

  @override
  Widget build(BuildContext context) {
    final router = context.read<AppRouter>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(label),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          bool hasUrl = state.authUrl != null;

          return Row(
            children: [
              ElevatedButton(
                onPressed: hasUrl ? null : () {
                  context.loginBloc.add(FetchAuthUrl());
                },
                child: Text('Fetch Auth Url'),
              ),
              ElevatedButton(
                onPressed: hasUrl ? () async {
                  await _launchUrl(state.authUrl!);
                  //router.router.pop();
                } : null,
                child: Text('Matrica'),
              ),
            ],
          );
        }
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

}

