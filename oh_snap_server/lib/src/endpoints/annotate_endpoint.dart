
import 'package:oh_snap_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class AnnotateEndpoint extends Endpoint {

  //final dio = Dio()..interceptors.add(LogInterceptor(responseBody: true)); // Provide a dio instance
  //final dotenv = DotEnv(includePlatformEnvironment: true);

  Future<NftList> fetchNfts(Session session, String walletAddress) async {
    session.log('fetching nfts for $walletAddress');
    /*dotenv.load();

    var apiKey = dotenv['helius_apikey']!;

    try {
      var call = AssetsByOwnerQueryCall(
        params: AssetsByOwnerQuery(
          ownerAddress: walletAddress,
          limit: 2,
        ),
      );
      var response = await HeliusApi(dio).getAssetsByOwner(apiKey, call);

      var list = response.result
          .items
          .map((resultNft) => Nft(name: resultNft.id, imageUrl: resultNft.content.links.image)).toList();

      return NftList(
        items: list,
        total: list.length,
        page: 1,
      );
    } catch (e) {
      session.log('getAssetsByOwner', exception: e);
      rethrow;
    }*/
    return NftList(items: [], total: 0, page: 1);
  }

  /*Future<void> annotate(Session session, String walletAddress) async {
  }*/
}