import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class WelcomeHeader extends StatelessWidget {
  WelcomeHeader({Key key, this.name}) : super(key: key);
  String name;
  String cartCounter = "99";
  String notificationCounter = "99";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, $name",
                overflow: TextOverflow.ellipsis,
                style: CustomFont.heading24,
              ),
              Text("How are you today?", style: CustomFont.medium12),
            ],
          ),
        ),
        SpacerWidth(w: 20),
        SizedBox(
          width: CustomScreen(context).width / 3.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push("/cart");
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/svg/cart-shopping-solid.svg",
                        height: 20,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 15,
                          minHeight: 15,
                        ),
                        child: Center(
                          child: Text(
                            cartCounter,
                            style: CustomFont.badge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push("/notification");
                },
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SvgPicture.asset(
                        "assets/svg/bell-solid.svg",
                        height: 20,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 15,
                          minHeight: 15,
                        ),
                        child: Center(
                          child: Text(
                            '99',
                            style: CustomFont.badge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push("/homepage/3");
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/user-solid.svg",
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
