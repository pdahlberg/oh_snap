import 'package:hive/hive.dart';
import 'package:oh_snap_flutter/adapters/hive/entity/type_ids.dart';

part 'login_entity.g.dart';

@HiveType(typeId: typeIdLogin)
class LoginEntity extends HiveObject {
  LoginEntity({
    required this.matricaId,
    required this.accessToken,
  });

  @HiveField(0)
  String matricaId;

  @HiveField(1)
  String accessToken;

}
