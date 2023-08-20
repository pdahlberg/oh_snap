import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

/*

  {
  "id": "f929f8f3-3201-488c-a555-19af5a0b284b",
  "username": "incrementalist",
  "isAdmin": false,
  "registered": true,
  "isSearchSynced": true,
  "createdDate": "2021-12-30T13:48:07.179Z",
  "updatedDate": "2023-08-10T16:41:00.648Z",
  "profile": {
    "id": "26ba18a4-7db0-4cc0-a099-62f2da2a2a6d",
    "name": "incrementalist",
    "vanityURL": "incrementalist",
    "about": "",
    "website": "",
    "emailVerified": true,
    "twitter": "",
    "twitterExternalId": null,
    "showTwitter": true,
    "discord": "",
    "pfp": "https://arweave.net/UOEXWMSd0YtLH7BErnKr1qDE-19U_Pw1kwxDFPssZXE",
    "banner": "https://www.arweave.net/DiSbEkNw7FhF8g_DvjbRZJMSASaRGLGdLjS4Gn31lEE?ext=png",
    "bannerOffsetTop": 0,
    "bannerBorder": null,
    "bannerNFTCount": 3,
    "bannerLeft": "https://www.arweave.net/c52ApX1STuOUpmqEHQGDJFl5erNQL8w37AFfka3Fb80?ext=png",
    "bannerMiddle": "https://www.arweave.net/vac53crMat0coHmAgwK6noA92NhEC2tY6oGHzFIbUm0?ext=png",
    "bannerRight": "https://www.arweave.net/TpClh0DIVt-R4IxzAOSSBO1bLcXtSP4Eh0WEF3MRF4Y?ext=png",
    "border": null,
    "showGraveyard": null,
    "createdDate": "2022-01-01T09:50:07.720Z",
    "updatedDate": "2023-08-10T18:03:47.209Z"
  }
}
    */

@JsonSerializable()
class UserProfileResponse {
  final String id;
  final String username;

  UserProfileResponse({
    required this.id,
    required this.username,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => _$UserProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);

  @override
  String toString() {
    return 'UserProfileResponse{id: $id, username: $username}';
  }

}




