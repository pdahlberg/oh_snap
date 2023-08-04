
import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:oh_snap_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AnnotateEndpoint extends Endpoint {

  final dio = Dio(); // Provide a dio instance
  final dotenv = DotEnv(includePlatformEnvironment: true);

  Future<Nft> fetchNfts(Session session, String walletAddress) async {
    session.log('...');
    dotenv.load();

    return Nft(name: 'name', imageUrl: 'url_1');
  }

}