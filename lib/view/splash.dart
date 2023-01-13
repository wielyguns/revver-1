import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      loginLoad(email, password).then((val) async {
        if (val['status'] == 200) {
          await FirebaseMessaging.instance.subscribeToTopic("event");
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
      body: SizedBox(
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 100,
                width: 100,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Image.asset("assets/img/revver-icon.png"),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: LinearProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 213, 160, 104),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 242, 242, 242),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
