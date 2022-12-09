// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/globals.dart';

class CustomHeader extends StatelessWidget with PreferredSizeWidget {
  CustomHeader({Key key, this.isPop, this.svgName, this.title, this.route})
      : super(key: key);
  bool isPop;
  final String title;
  final String svgName;
  final String route;

  @override
  Widget build(BuildContext context) {
    isPop ??= false;
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Image.asset(
        "assets/img/revver-white.png",
        width: 100,
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/background-resize.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 13,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: kToolbarHeight),
              Text(
                title,
                style: CustomFont(CustomColor.whiteColor, 24, FontWeight.bold)
                    .font,
              ),
            ],
          ),
        ),
      ),
      leading: (isPop)
          ? CupertinoNavigationBarBackButton(
              color: CustomColor.whiteColor,
              onPressed: () => GoRouter.of(context).pop())
          : SizedBox(),
      actions: [
        (svgName == null || svgName == "")
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(route);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(
                    'assets/svg/$svgName',
                    height: 20,
                    color: CustomColor.whiteColor,
                  ),
                )),
      ],
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   isPop ??= false;
  //   return CupertinoNavigationBar(
  //       backgroundColor: CustomColor.backgroundColor,
  //       border: Border(bottom: BorderSide.none),
  //       leading: (isPop)
  //           ? CupertinoNavigationBarBackButton(
  //               onPressed: () => GoRouter.of(context).pop())
  //           : SizedBox(),
  //       middle: Text(title, style: CustomFont.heading18),
  //       trailing: (svgName == null || svgName == "")
  //           ? SizedBox()
  //           : GestureDetector(
  //               onTap: () {
  //                 GoRouter.of(context).push(route);
  //               },
  //               child: SvgPicture.asset('assets/svg/$svgName', height: 20)));
  // }

  @override
  Size get preferredSize => Size.fromHeight(150);
}
