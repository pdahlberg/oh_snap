/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:oh_snap_client/src/protocol/nft_list.dart' as _i3;
import 'package:oh_snap_client/src/protocol/snap_info.dart' as _i4;
import 'dart:io' as _i5;
import 'protocol.dart' as _i6;

class _EndpointAnnotate extends _i1.EndpointRef {
  _EndpointAnnotate(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'annotate';

  _i2.Future<_i3.NftList> fetchNfts(String walletAddress) =>
      caller.callServerEndpoint<_i3.NftList>(
        'annotate',
        'fetchNfts',
        {'walletAddress': walletAddress},
      );
}

class _EndpointSnap extends _i1.EndpointRef {
  _EndpointSnap(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'snap';

  _i2.Future<_i4.SnapInfo> capture(
    String url,
    String walletAddress,
    bool removeButtons,
  ) =>
      caller.callServerEndpoint<_i4.SnapInfo>(
        'snap',
        'capture',
        {
          'url': url,
          'walletAddress': walletAddress,
          'removeButtons': removeButtons,
        },
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i5.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i6.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    annotate = _EndpointAnnotate(this);
    snap = _EndpointSnap(this);
  }

  late final _EndpointAnnotate annotate;

  late final _EndpointSnap snap;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'annotate': annotate,
        'snap': snap,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
