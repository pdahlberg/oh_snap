
import 'package:equatable/equatable.dart';

abstract class MintEvent extends Equatable {
  const MintEvent();
  @override List<Object?> get props => [];
}

class MintRefreshed extends MintEvent {}



