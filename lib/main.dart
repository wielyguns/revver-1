import 'package:flutter/material.dart';
import 'package:revver/globals.dart';
import 'package:revver/route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Revver',
      theme: ThemeData(scaffoldBackgroundColor: CustomColor.whiteColor),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}