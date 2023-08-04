
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class MintState extends Equatable {

  final String? msg;

  const MintState({
    this.msg = '',
  });

  MintState copyWith({
    ValueGetter<String?>? msg,
  }) {
    return MintState(
      msg: msg != null ? msg() : this.msg,
    );
  }

  @override
  List<Object?> get props => [msg];

}


