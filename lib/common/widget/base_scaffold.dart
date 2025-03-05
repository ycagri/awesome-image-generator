import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const BaseScaffold({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(title),
      backgroundColor: Theme.of(context).primaryColor,
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    body: child,
  );
}
