/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:oh_snap_client/src/protocol/nft.dart' as _i3;
import 'dart:io' as _i4;
import 'protocol.dart' as _i5;

class _EndpointAnnotate extends _i1.EndpointRef {
  _EndpointAnnotate(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'annotate';

  _i2.Future<_i3.Nft> fetchNfts(String walletAddress) =>
      caller.callServerEndpoint<_i3.Nft>(
        'annotate',
        'fetchNfts',
        {'walletAddress': walletAddress},
      );
}

class _EndpointExample extends _i1.EndpointRef {
  _EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(
    String url,
    String walletAddress,
    bool removeButtons,
  ) =>
      caller.callServerEndpoint<String>(
        'example',
        'hello',
        {
          'url': url,
          'walletAddress': walletAddress,
          'removeButtons': removeButtons,
        },
      );

  _i2.Future<String> upload(List<int> screenshot) =>
      caller.callServerEndpoint<String>(
        'example',
        'upload',
        {'screenshot': screenshot},
      );

  _i2.Future<void> createNft(
    String nftName,
    String imageUrl,
    String source,
  ) =>
      caller.callServerEndpoint<void>(
        'example',
        'createNft',
        {
          'nftName': nftName,
          'imageUrl': imageUrl,
          'source': source,
        },
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i4.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i5.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    annotate = _EndpointAnnotate(this);
    example = _EndpointExample(this);
  }

  late final _EndpointAnnotate annotate;

  late final _EndpointExample example;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'annotate': annotate,
        'example': example,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
