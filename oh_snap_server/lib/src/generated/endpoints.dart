/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/annotate_endpoint.dart' as _i2;
import '../endpoints/snap_endpoint.dart' as _i3;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'annotate': _i2.AnnotateEndpoint()
        ..initialize(
          server,
          'annotate',
          null,
        ),
      'snap': _i3.SnapEndpoint()
        ..initialize(
          server,
          'snap',
          null,
        ),
    };
    connectors['annotate'] = _i1.EndpointConnector(
      name: 'annotate',
      endpoint: endpoints['annotate']!,
      methodConnectors: {
        'fetchNfts': _i1.MethodConnector(
          name: 'fetchNfts',
          params: {
            'walletAddress': _i1.ParameterDescription(
              name: 'walletAddress',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['annotate'] as _i2.AnnotateEndpoint).fetchNfts(
            session,
            params['walletAddress'],
          ),
        )
      },
    );
    connectors['snap'] = _i1.EndpointConnector(
      name: 'snap',
      endpoint: endpoints['snap']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'url': _i1.ParameterDescription(
              name: 'url',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'walletAddress': _i1.ParameterDescription(
              name: 'walletAddress',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'removeButtons': _i1.ParameterDescription(
              name: 'removeButtons',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['snap'] as _i3.SnapEndpoint).create(
            session,
            params['url'],
            params['walletAddress'],
            params['removeButtons'],
          ),
        ),
        'createNft': _i1.MethodConnector(
          name: 'createNft',
          params: {
            'url': _i1.ParameterDescription(
              name: 'url',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'walletAddress': _i1.ParameterDescription(
              name: 'walletAddress',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'removeButtons': _i1.ParameterDescription(
              name: 'removeButtons',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['snap'] as _i3.SnapEndpoint).createNft(
            session,
            params['url'],
            params['walletAddress'],
            params['removeButtons'],
          ),
        ),
      },
    );
  }
}
