import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:oh_snap_client/oh_snap_client.dart';
import 'package:oh_snap_flutter/features/mint/view/mint_page.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';
import 'package:oh_snap_flutter/view/main_page.dart';

class SnapFormBloc extends FormBloc<String, String> {

  final AppRouter _appRouter;
  final Client _client;
  final url = TextFieldBloc(validators: [ FieldBlocValidators.required ]);
  final showSuccessResponse = BooleanFieldBloc();

  SnapFormBloc(this._appRouter, this._client) {
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
  );

  @override
  Future<void> onSubmitting() async {
    try {
      //var result = await _client.snap.create(url.value, 'Ufw2M6ojcXDcaFhU3zWXbsGEUYYADoqEz3wLQpc6dFh', false);
      await _client.snap.createNft('', '', false);
      //debugPrint('result: ${result.id}');
      emitSuccess();
      _appRouter.router.push(MintPage.path, );
    } on Exception catch (e) {
      emitFailure(failureResponse: 'Error: $e');
    }

  }

}
