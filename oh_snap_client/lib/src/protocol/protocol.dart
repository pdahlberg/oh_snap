/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'nft.dart' as _i2;
import 'nft_list.dart' as _i3;
import 'payment_requirement.dart' as _i4;
import 'post.dart' as _i5;
import 'snap_info.dart' as _i6;
import 'task.dart' as _i7;
import 'task_status.dart' as _i8;
import 'task_type.dart' as _i9;
import 'user.dart' as _i10;
import 'protocol.dart' as _i11;
export 'nft.dart';
export 'nft_list.dart';
export 'payment_requirement.dart';
export 'post.dart';
export 'snap_info.dart';
export 'task.dart';
export 'task_status.dart';
export 'task_type.dart';
export 'user.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Map<Type, _i1.constructor> customConstructors = {};

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (customConstructors.containsKey(t)) {
      return customConstructors[t]!(data, this) as T;
    }
    if (t == _i2.Nft) {
      return _i2.Nft.fromJson(data, this) as T;
    }
    if (t == _i3.NftList) {
      return _i3.NftList.fromJson(data, this) as T;
    }
    if (t == _i4.PaymentRequirement) {
      return _i4.PaymentRequirement.fromJson(data) as T;
    }
    if (t == _i5.Post) {
      return _i5.Post.fromJson(data, this) as T;
    }
    if (t == _i6.SnapInfo) {
      return _i6.SnapInfo.fromJson(data, this) as T;
    }
    if (t == _i7.Task) {
      return _i7.Task.fromJson(data, this) as T;
    }
    if (t == _i8.TaskStatus) {
      return _i8.TaskStatus.fromJson(data) as T;
    }
    if (t == _i9.TaskType) {
      return _i9.TaskType.fromJson(data) as T;
    }
    if (t == _i10.User) {
      return _i10.User.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.Nft?>()) {
      return (data != null ? _i2.Nft.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.NftList?>()) {
      return (data != null ? _i3.NftList.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.PaymentRequirement?>()) {
      return (data != null ? _i4.PaymentRequirement.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Post?>()) {
      return (data != null ? _i5.Post.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i6.SnapInfo?>()) {
      return (data != null ? _i6.SnapInfo.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i7.Task?>()) {
      return (data != null ? _i7.Task.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i8.TaskStatus?>()) {
      return (data != null ? _i8.TaskStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.TaskType?>()) {
      return (data != null ? _i9.TaskType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.User?>()) {
      return (data != null ? _i10.User.fromJson(data, this) : null) as T;
    }
    if (t == List<_i11.Nft>) {
      return (data as List).map((e) => deserialize<_i11.Nft>(e)).toList()
          as dynamic;
    }
    if (t == _i1.getType<List<_i11.Task>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i11.Task>(e)).toList()
          : null) as dynamic;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object data) {
    if (data is _i2.Nft) {
      return 'Nft';
    }
    if (data is _i3.NftList) {
      return 'NftList';
    }
    if (data is _i4.PaymentRequirement) {
      return 'PaymentRequirement';
    }
    if (data is _i5.Post) {
      return 'Post';
    }
    if (data is _i6.SnapInfo) {
      return 'SnapInfo';
    }
    if (data is _i7.Task) {
      return 'Task';
    }
    if (data is _i8.TaskStatus) {
      return 'TaskStatus';
    }
    if (data is _i9.TaskType) {
      return 'TaskType';
    }
    if (data is _i10.User) {
      return 'User';
    }
    return super.getClassNameForObject(data);
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    if (data['className'] == 'Nft') {
      return deserialize<_i2.Nft>(data['data']);
    }
    if (data['className'] == 'NftList') {
      return deserialize<_i3.NftList>(data['data']);
    }
    if (data['className'] == 'PaymentRequirement') {
      return deserialize<_i4.PaymentRequirement>(data['data']);
    }
    if (data['className'] == 'Post') {
      return deserialize<_i5.Post>(data['data']);
    }
    if (data['className'] == 'SnapInfo') {
      return deserialize<_i6.SnapInfo>(data['data']);
    }
    if (data['className'] == 'Task') {
      return deserialize<_i7.Task>(data['data']);
    }
    if (data['className'] == 'TaskStatus') {
      return deserialize<_i8.TaskStatus>(data['data']);
    }
    if (data['className'] == 'TaskType') {
      return deserialize<_i9.TaskType>(data['data']);
    }
    if (data['className'] == 'User') {
      return deserialize<_i10.User>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
