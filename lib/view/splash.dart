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
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String mess;

  requestPermissionFCM() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // if (message.data['type'] == 'chat') {
    //   Navigator.pushNamed(
    //     context,
    //     '/chat',
    //     arguments: ChatArguments(message),
    //   );
    // }
    print(message.data);
    setState(() {
      mess = message.data.toString();
    });
  }

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
    requestPermissionFCM();
    setupInteractedMessage();
    super.initState();
    // Timer(Duration(milliseconds: 3000), () => checkAuth());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      // child: CupertinoActivityIndicator(),
      child: Text(mess ?? ""),
    ));
  }
}
