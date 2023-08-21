import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oh_snap_flutter/infra/app.dart';
import 'package:oh_snap_flutter/infra/dependencies.dart';
import 'package:provider/provider.dart';

class ProductionEnvironment extends StatelessWidget {

  const ProductionEnvironment({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...Dependencies.common(),
        ...Dependencies.commonWithDependency(),
      ],
      child: MultiBlocProvider(
        providers: [
          ...Dependencies.blocs(),
        ],
        child: const App(),
      ),
    );
  }

}
