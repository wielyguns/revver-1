import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/globals.dart';
import 'package:revver/view/account.dart';
import 'package:revver/view/event.dart';
import 'package:revver/view/home.dart';
import 'package:revver/view/homepage.dart';
import 'package:revver/view/leads.dart';
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
      theme: ThemeData(scaffoldBackgroundColor: CustomColor.whiteColor),
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
      GoRoute(
        path: '/homepage',
        builder: (context, state) => const Homepage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/event',
        builder: (context, state) => const Event(),
      ),
      GoRoute(
        path: '/leads',
        builder: (context, state) => const Leads(),
      ),
      GoRoute(
        path: '/account',
        builder: (context, state) => const Account(),
      ),
    ],
  );
}
