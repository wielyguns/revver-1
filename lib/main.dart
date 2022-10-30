import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/view/login.dart';
import 'package:revver/view/registration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return MaterialApp.router(
      title: 'Revver',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: '/registration',
        builder: (context, state) => const Registration(),
      ),
    ],
  );
}
