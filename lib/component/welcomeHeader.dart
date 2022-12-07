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
            "Hi, $name",
            overflow: TextOverflow.ellipsis,
            style: CustomFont.heading18,
          ),
          Text("How are you today?", style: CustomFont.medium12),
        ],
      ),
    );
  }
}
