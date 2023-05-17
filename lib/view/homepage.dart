// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/globals.dart';
import 'package:revver/view/accoount/account.dart';
import 'package:revver/view/event/event.dart';
import 'package:revver/view/home/home.dart';
import 'package:revver/view/leads/leads.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  return;
}

class Homepage extends StatefulWidget {
  Homepage({Key key, this.index}) : super(key: key);
  int index;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Event(),
    Leads(),
    Account(),
  ];

  notification() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      FirebaseMessaging.instance.getInitialMessage().then((message) {
        if (message != null) {
          final redirectRoute = message.data['route'];
          GoRouter.of(context).push(redirectRoute);
        }
      });

      FirebaseMessaging.onMessage.listen((message) {
        if (message != null) {
          final redirectRoute = message.data['route'];
          GoRouter.of(context).push(redirectRoute);
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        if (message != null) {
          final redirectRoute = message.data['route'];
          GoRouter.of(context).push(redirectRoute);
        }
      });
    }
  }

  @override
  void initState() {
    notification();
    super.initState();
    if (widget.index != null) {
      setState(() {
        _currentIndex = widget.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          boxShadow: [
            BoxShadow(
              color: CustomColor.whiteColor.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 13,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SalomonBottomBar(
          selectedColorOpacity: 1,
          margin: EdgeInsets.symmetric(horizontal: 35, vertical: 18),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/home.svg",
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/svg/home.svg",
                height: 24,
                color: CustomColor.whiteColor,
              ),
              title: Text(
                "Home",
                style: CustomFont(CustomColor.whiteColor, 12, FontWeight.bold)
                    .font,
              ),
              selectedColor: CustomColor.brownColor,
            ),

            /// Event
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/event.svg",
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/svg/event.svg",
                height: 24,
                color: CustomColor.whiteColor,
              ),
              title: Text(
                "Event",
                style: CustomFont(CustomColor.whiteColor, 12, FontWeight.bold)
                    .font,
              ),
              selectedColor: CustomColor.brownColor,
            ),

            /// Leads
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/leads.svg",
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/svg/leads.svg",
                height: 24,
                color: CustomColor.whiteColor,
              ),
              title: Text(
                "Leads",
                style: CustomFont(CustomColor.whiteColor, 12, FontWeight.bold)
                    .font,
              ),
              selectedColor: CustomColor.brownColor,
            ),

            /// Account
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/account.svg",
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/svg/account.svg",
                height: 24,
                color: CustomColor.whiteColor,
              ),
              title: Text(
                "Account",
                style: CustomFont(CustomColor.whiteColor, 12, FontWeight.bold)
                    .font,
              ),
              selectedColor: CustomColor.brownColor,
            ),
          ],
        ),
      ),
    );
  }
}
