import 'package:dio/dio.dart';
import 'package:oh_snap_server/src/adapters/helius/assets_by_owner_query.dart';
import 'package:retrofit/retrofit.dart';

part 'helius_api.g.dart';

@RestApi(baseUrl: "https://mainnet.helius-rpc.com/?api-key={apiKey}")
abstract class HeliusApi {
  factory HeliusApi(Dio dio, {String baseUrl}) = _HeliusApi;

  @POST("/getAssetsByOwner")
  Future<String> getAssetsByOwner(
    @Path("apiKey") String apiKey,
    @Body() AssetsByOwnerQuery query,
  );
}

