import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:revver/controller/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString('email');
    final String password = prefs.getString('password');
    if (email != null && password != null) {
      loginLoad(email, password).then((val) {
        if (val['status'] == 200) {
          GoRouter.of(context).go("/homepage/0");
        } else {
          GoRouter.of(context).go("/login");
        }
      });
    } else {
      GoRouter.of(context).go("/login");
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3000), () => checkAuth());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
        // child: Column(
        //   children: [
        //     Text("Message: $mess" ?? "Message: null"),
        //     Text("Token: $token" ?? "Token: null"),
        //   ],
        // ),
      ),
    );
  }
}
