import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class CustomHeader extends StatelessWidget with PreferredSizeWidget {
  CustomHeader({Key key, this.isPop, this.svgName, this.title})
      : super(key: key);
  bool isPop;
  String title;
  String svgName;

  @override
  Widget build(BuildContext context) {
    isPop ??= false;
    return CupertinoNavigationBar(
        backgroundColor: CustomColor.whiteColor,
        border: const Border(bottom: BorderSide.none),
        leading: (isPop)
            ? CupertinoNavigationBarBackButton(
                onPressed: () => GoRouter.of(context).pop())
            : const SizedBox(),
        middle: Text(title, style: CustomFont.heading18),
        trailing: (svgName == null || svgName == "")
            ? const SizedBox()
            : SvgPicture.asset('assets/svg/$svgName'));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
