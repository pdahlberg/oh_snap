/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:oh_snap_client/src/protocol/nft_list.dart' as _i3;
import 'package:oh_snap_client/src/protocol/user.dart' as _i4;
import 'package:oh_snap_client/src/protocol/post.dart' as _i5;
import 'dart:io' as _i6;
import 'protocol.dart' as _i7;

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

class _EndpointAuth extends _i1.EndpointRef {
  _EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i2.Future<String> authLink(String clientGeneratedSecret) =>
      caller.callServerEndpoint<String>(
        'auth',
        'authLink',
        {'clientGeneratedSecret': clientGeneratedSecret},
      );

  _i2.Future<_i4.User?> fetchUserWithState(String clientGeneratedSecret) =>
      caller.callServerEndpoint<_i4.User?>(
        'auth',
        'fetchUserWithState',
        {'clientGeneratedSecret': clientGeneratedSecret},
      );

  _i2.Future<_i4.User?> fetchUser(
    String matricaId,
    String accessToken,
  ) =>
      caller.callServerEndpoint<_i4.User?>(
        'auth',
        'fetchUser',
        {
          'matricaId': matricaId,
          'accessToken': accessToken,
        },
      );
}

class _EndpointSnap extends _i1.EndpointRef {
  _EndpointSnap(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'snap';

  _i2.Future<_i5.Post> create(
    String url,
    String walletAddress,
    bool removeButtons,
  ) =>
      caller.callServerEndpoint<_i5.Post>(
        'snap',
        'create',
        {
          'url': url,
          'walletAddress': walletAddress,
          'removeButtons': removeButtons,
        },
      );

  _i2.Future<void> processTasks() => caller.callServerEndpoint<void>(
        'snap',
        'processTasks',
        {},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i6.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i7.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    annotate = _EndpointAnnotate(this);
    auth = _EndpointAuth(this);
    snap = _EndpointSnap(this);
  }

  late final _EndpointAnnotate annotate;

  late final _EndpointAuth auth;

  late final _EndpointSnap snap;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'annotate': annotate,
        'auth': auth,
        'snap': snap,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
