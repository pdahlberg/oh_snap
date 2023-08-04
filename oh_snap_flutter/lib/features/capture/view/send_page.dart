

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:oh_snap_flutter/features/capture/state/snap_form_bloc.dart';

class SnapPage extends StatelessWidget {

  static const label = "Snap";
  static const path = "/snap";

  const SnapPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(label),
      ),
      body: FormBlocListener<SnapFormBloc, String, String>(
        onFailure: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('state.failureResponse')));
          },
          child: Builder(
            builder: (context) {
              final snapFormBloc = context.read<SnapFormBloc>();
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
                  child: Column(
                    children: <Widget>[
                      TextFieldBlocBuilder(
                        textFieldBloc: snapFormBloc.url,
                        autofillHints: const [AutofillHints.url],
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                          labelText: 'URL',
                          prefixIcon: Icon(Icons.link),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: snapFormBloc.submit,
                        child: const Text('SNAP'),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
      ),
    );
  }

}
