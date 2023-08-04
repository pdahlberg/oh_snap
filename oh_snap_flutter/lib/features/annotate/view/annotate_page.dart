import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_flutter/features/annotate/state/annotate_bloc.dart';
import 'package:oh_snap_flutter/features/annotate/state/annotate_events.dart';
import 'package:oh_snap_flutter/features/annotate/state/annotate_state.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';
import 'package:oh_snap_flutter/infra/extension_methods.dart';

class AnnotatePage extends StatelessWidget {

  static const String label = 'Annotate';
  static const String path = '/annotate';

  const AnnotatePage({ super.key });

  @override
  Widget build(BuildContext context) {
    final router = context.read<AppRouter>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(label),
      ),
      body: BlocBuilder<AnnotateBloc, AnnotateState>(
        builder: (context, state) {
          List<Widget> children = [];
          if(state.nfts.isNotEmpty) {
            children = [
              /*CachedNetworkImage(
                width: 320,
                height: 320,
                imageUrl: state.nfts[0].imageUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )*/
            ];
          }

          return Column(
            children: [
              ...children,
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      router.router.pop();
                    },
                    child: Text('back'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.annotationBloc.add(FetchNfts());
                    },
                    child: Text('load'),
                  ),
                ],
              ),
            ],
          );
        }
      ),
    );
  }

}

