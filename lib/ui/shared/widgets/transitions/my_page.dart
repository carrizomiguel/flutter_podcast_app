import 'package:flutter/material.dart';

class MyPage<T> extends Page<T> {
  const MyPage({required this.child, LocalKey? key}) : super(key: key);

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}