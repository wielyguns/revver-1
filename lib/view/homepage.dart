// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revver/globals.dart';
import 'package:revver/view/accoount/account.dart';
import 'package:revver/view/event/event.dart';
import 'package:revver/view/home/home.dart';
import 'package:revver/view/leads/leads.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// ignore: must_be_immutable
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

  @override
  void initState() {
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
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/house-solid.svg",
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/svg/house-solid.svg",
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

            /// Likes
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/calendar-days-solid.svg",
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/svg/calendar-days-solid.svg",
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

            /// Search
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/clipboard-solid.svg",
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/svg/clipboard-solid.svg",
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

            /// Profile
            SalomonBottomBarItem(
              icon: SvgPicture.asset(
                "assets/svg/user-solid.svg",
                height: 24,
              ),
              activeIcon: SvgPicture.asset(
                "assets/svg/user-solid.svg",
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
