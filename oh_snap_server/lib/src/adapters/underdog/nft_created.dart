import 'package:json_annotation/json_annotation.dart';

part 'nft_created.g.dart';

@JsonSerializable()
class NftCreated {
  int projectId;
  String transactionId;
  int nftId;
  String? mintAddress;

  NftCreated({
    required this.projectId,
    required this.transactionId,
    required this.nftId,
    this.mintAddress,
  });

  factory NftCreated.fromJson(Map<String, dynamic> json) => _$NftCreatedFromJson(json);
  Map<String, dynamic> toJson() => _$NftCreatedToJson(this);

  @override
  String toString() {
    return 'NftCreated{$nftId, projectId=$projectId, tx=$transactionId, mintAddress=$mintAddress}';
  }
}
