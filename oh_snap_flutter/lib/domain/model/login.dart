
import 'package:oh_snap_client/oh_snap_client.dart';

class Login {

  final String matricaId;
  final String accessToken;

  Login(this.matricaId, this.accessToken);

  Login.fromUser(User user) :
    matricaId = user.matricaId,
    accessToken = user.matricaAccessToken;

}