
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:oh_snap_client/oh_snap_client.dart';

class AnnotateState extends Equatable {

  final String? msg;
  final List<Nft> nfts;

  const AnnotateState({
    this.msg = '',
    this.nfts = const [],
  });

  AnnotateState copyWith({
    ValueGetter<String?>? msg,
    List<Nft>? nfts,
  }) {
    return AnnotateState(
      msg: msg != null ? msg() : this.msg,
      nfts: nfts ?? this.nfts,
    );
  }

  @override
  List<Object?> get props => [msg, nfts];

}


