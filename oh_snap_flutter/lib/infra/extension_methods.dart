
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_flutter/features/annotate/state/annotate_bloc.dart';
import 'package:oh_snap_flutter/features/login/state/login_bloc.dart';

extension BuildContextExtensions on BuildContext {
  AnnotateBloc get annotationBloc => read();
  LoginBloc get loginBloc => read();
}

extension ObjectExt<T> on T {
  R let<R>(R Function(T that) op) => op(this);
}
