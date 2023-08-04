import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_flutter/infra/app_router.dart';

class MintPage extends StatelessWidget {

  static const String label = 'Mint';
  static const String path = '/mint';

  const MintPage({ super.key });

  @override
  Widget build(BuildContext context) {
    final router = context.read<AppRouter>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(label),
      ),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: "https://file.sdrive.app/whqbpslp5oz9qhxkva60f21h",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          ElevatedButton(
            onPressed: () {
              router.router.pop();
            },
            child: Text('back'),
          ),
        ],
      ),
    );
  }

}

