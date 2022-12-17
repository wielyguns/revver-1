import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              detailMenu(context, "assets/svg/note-new.svg", "Note", "/note"),
              detailMenu(context, "assets/svg/e-learning-new.svg", "E-Learning",
                  "/e-learning"),
              detailMenu(context, "assets/svg/plan-new.svg", "Plan", "/plan"),
              detailMenu(context, "assets/svg/e-health-new.svg", "E-Health",
                  "/e-health-form"),
            ],
          ),
          SpacerHeight(h: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              detailMenu(
                  context, "assets/svg/goals-new.svg", "Goals", "/e-learning"),
              detailMenu(context, "assets/svg/support-new.svg", "Support",
                  "/e-learning"),
              detailMenu(
                  context, "assets/svg/report-new.svg", "Report", "/report"),
              detailMenu(context, "assets/svg/report-new.svg", "Revver",
                  "/company-profile"),
            ],
          ),
        ],
      ),
    );
  }

  detailMenu(BuildContext context, String image, String title, String goTo) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(goTo);
      },
      child: Column(
        children: [
          SvgPicture.asset(image, height: 30),
          SpacerHeight(h: 5),
          Text(
            title,
            style: CustomFont.regular12,
          ),
        ],
      ),
    );
  }
}
