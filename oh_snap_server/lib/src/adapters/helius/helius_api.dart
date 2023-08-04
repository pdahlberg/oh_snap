import 'package:dio/dio.dart';
import 'package:oh_snap_server/src/adapters/helius/assets_by_owner_query.dart';
import 'package:oh_snap_server/src/adapters/helius/nft_response.dart';
import 'package:retrofit/retrofit.dart';

part 'helius_api.g.dart';

@RestApi(baseUrl: "https://rpc.helius.xyz")
abstract class HeliusApi {
  factory HeliusApi(Dio dio, {String baseUrl}) = _HeliusApi;

  @POST("/")
  Future<JsonRpcResponse> getAssetsByOwner(
    @Query("api-key") String apiKey,
    @Body() AssetsByOwnerQueryCall query,
  );

  /*@POST("/")
  Future<List<NftResponse>> jsonRpc(
    @Path("apiKey") String apiKey,
    @Body() AssetsByOwnerQuery query,
  );*/
}

