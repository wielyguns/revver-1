import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/controller/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

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
          GoRouter.of(context).push("/homepage");
        } else {
          GoRouter.of(context).push("/login");
        }
      });
    } else {
      GoRouter.of(context).push("/login");
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3000), () => checkAuth());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SizedBox());
  }
}
