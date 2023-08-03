import 'package:dio/dio.dart';
import 'package:oh_snap_server/src/underdog/create_nft.dart';
import 'package:oh_snap_server/src/underdog/nft_created.dart';
import 'package:oh_snap_server/src/underdog/underdog_project.dart';
import 'package:retrofit/retrofit.dart';

part 'underdog_api.g.dart';

@RestApi(baseUrl: "https://dev.underdogprotocol.com/v2")
abstract class UnderdogApi {
  factory UnderdogApi(Dio dio, {String baseUrl}) = _UnderdogApi;

  @GET("/projects/{projectId}")
  Future<UnderdogProject> fetchProject(
    @Header("Authorization") String auth,
    @Path("projectId") int projectId,
  );

  @POST("/projects/{projectId}/nfts")
  Future<NftCreated> createNft(
    @Header("Authorization") String auth,
    @Path("projectId") int projectId,
    @Body() CreateNft body,
  );
}


