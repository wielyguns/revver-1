import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
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
    return CupertinoNavigationBar(
        backgroundColor: CustomColor.whiteColor,
        border: Border(bottom: BorderSide.none),
        leading: (isPop)
            ? CupertinoNavigationBarBackButton(
                onPressed: () => GoRouter.of(context).pop())
            // ignore: prefer_const_constructors
            : SizedBox(),
        middle: Text(title, style: CustomFont.heading18),
        trailing: (svgName == null || svgName == "")
            ? SizedBox()
            : GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(route);
                },
                child: SvgPicture.asset('assets/svg/$svgName', height: 20)));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
