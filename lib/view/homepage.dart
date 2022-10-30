import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revver/globals.dart';
import 'package:revver/view/account.dart';
import 'package:revver/view/event.dart';
import 'package:revver/view/home.dart';
import 'package:revver/view/leads.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var _currentIndex = 0;
  final List<Widget> _children = [
    const Home(),
    const Event(),
    const Leads(),
    const Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: CustomColor.goldColor,
          boxShadow: [
            BoxShadow(
              color: CustomColor.blackColor,
              spreadRadius: 20,
              blurRadius: 50,
              offset: const Offset(0, 50),
            ),
          ],
        ),
        child: SalomonBottomBar(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/house-solid.svg",
                height: 24,
              ),
              title: Text(
                "Home",
                style: CustomFont.bold12,
              ),
              selectedColor: Colors.black,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/calendar-days-solid.svg",
                height: 24,
              ),
              title: Text(
                "Event",
                style: CustomFont.bold12,
              ),
              selectedColor: Colors.black,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/clipboard-solid.svg",
                height: 24,
              ),
              title: Text(
                "Leads",
                style: CustomFont.bold12,
              ),
              selectedColor: Colors.black,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/user-solid.svg",
                height: 24,
              ),
              title: Text(
                "Account",
                style: CustomFont.bold12,
              ),
              selectedColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
