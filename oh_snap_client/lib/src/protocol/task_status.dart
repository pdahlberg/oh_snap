/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

enum TaskStatus with _i1.SerializableEntity {
  pending,
  completed,
  error,
  cancelled;

  static TaskStatus? fromJson(int index) {
    switch (index) {
      case 0:
        return pending;
      case 1:
        return completed;
      case 2:
        return error;
      case 3:
        return cancelled;
      default:
        return null;
    }
  }

  @override
  int toJson() => index;
}
