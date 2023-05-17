import 'package:flutter/material.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class WelcomeHeader extends StatelessWidget {
  WelcomeHeader({Key key, this.name}) : super(key: key);
  String name;
  String cartCounter = "99";
  String notificationCounter = "99";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Halo $name",
            overflow: TextOverflow.ellipsis,
            style: CustomFont(CustomColor.brownColor, 24, FontWeight.bold).font,
          ),
          Text(
            "Bagaimana kabarmu hari ini?",
            style: CustomFont(CustomColor.oldGreyColor, 12, null).font,
          ),
        ],
      ),
    );
  }
}
