import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {

  static const String label = 'Home';
  static const String path = '/';
  final Widget child;

  const MainPage({super.key, required this.child });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: child,
    );
  }

}

