import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:oh_snap_client/oh_snap_client.dart';
import 'package:oh_snap_flutter/domain/service/auth_service.dart';
import 'package:oh_snap_flutter/features/mint/view/mint_page.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';
import 'package:oh_snap_flutter/view/main_page.dart';

class SnapFormBloc extends FormBloc<String, String> {

  final AppRouter _appRouter;
  final Client _client;
  final AuthService _authService;
  final url = TextFieldBloc(validators: [ FieldBlocValidators.required ]);
  final showSuccessResponse = BooleanFieldBloc();

  SnapFormBloc(this._appRouter, this._client, this._authService) {
    addFieldBlocs(
      fieldBlocs: [
        url,
        showSuccessResponse,
      ],
    );
  }

  SnapFormBloc.of(BuildContext context) : this(
    context.read(),
    context.read(),
    context.read(),
  );

  @override
  Future<void> onSubmitting() async {
    try {
      final user = await _authService.fetchUser(); // This should be in an event instead
      var result = await _client.snap.create(user.id, url.value, 'Ufw2M6ojcXDcaFhU3zWXbsGEUYYADoqEz3wLQpc6dFh', false);
      await _client.snap.processTasks();
      //debugPrint('result: ${result.id}');
      emitSuccess();
      _appRouter.router.push(MintPage.path, );
    } on Exception catch (e) {
      emitFailure(failureResponse: 'Error: $e');
    }

  }

}
