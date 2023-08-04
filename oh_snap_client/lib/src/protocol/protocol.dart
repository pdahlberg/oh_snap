/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

library protocol; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'nft.dart' as _i2;
import 'nft_list.dart' as _i3;
import 'snap_info.dart' as _i4;
import 'protocol.dart' as _i5;
export 'nft.dart';
export 'nft_list.dart';
export 'snap_info.dart';
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
    if (t == _i4.SnapInfo) {
      return _i4.SnapInfo.fromJson(data, this) as T;
    }
    if (t == _i1.getType<_i2.Nft?>()) {
      return (data != null ? _i2.Nft.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i3.NftList?>()) {
      return (data != null ? _i3.NftList.fromJson(data, this) : null) as T;
    }
    if (t == _i1.getType<_i4.SnapInfo?>()) {
      return (data != null ? _i4.SnapInfo.fromJson(data, this) : null) as T;
    }
    if (t == List<_i5.Nft>) {
      return (data as List).map((e) => deserialize<_i5.Nft>(e)).toList()
          as dynamic;
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
    if (data is _i4.SnapInfo) {
      return 'SnapInfo';
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
    if (data['className'] == 'SnapInfo') {
      return deserialize<_i4.SnapInfo>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
