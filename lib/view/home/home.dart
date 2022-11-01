import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cartCounter = "99";
  String notificationCounter = "99";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Revver",
          style: CustomFont.subheading,
        ),
        backgroundColor: CustomColor.whiteColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            welcomeSection(context),
          ],
        ),
      ),
    );
  }

  Widget welcomeSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi Revver",
                overflow: TextOverflow.ellipsis,
                style: CustomFont.heading24,
              ),
              Text("How are you today?", style: CustomFont.medium12),
            ],
          ),
        ),
        const SpacerWidth(w: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
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
                onTap: () {},
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
                onTap: () {},
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
