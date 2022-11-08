import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/leadsOverview.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/test.dart';
import 'package:revver/globals.dart';

class Leads extends StatefulWidget {
  Leads({Key key}) : super(key: key);

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpacerHeight(h: 20),
                Text("Leads", style: CustomFont.heading24),
                SpacerHeight(h: 20),
                LeadsOverview(
                  cold: 1,
                  avarage: 1,
                  converted: 1,
                  hot: 1,
                  potential: 1,
                  underAvarage: 1,
                  warm: 1,
                ),
                SpacerHeight(h: 20),
                SearchForm(),
                SpacerHeight(h: 20),
                leadsList(),
                // SpacerHeight(h: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  leadsList() {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              leadsListWidget(),
              SpacerHeight(h: 10),
            ],
          );
        }),
      ),
    );
  }

  leadsListWidget() {
    return Row(
      children: [
        GestureDetector(
          onTap: (() => test(context)),
          child: SizedBox(
            height: 55,
            width: 55,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://wallpaperaccess.com/full/733834.png"),
                ),
              ],
            ),
          ),
        ),
        SpacerWidth(w: 10),
        Expanded(
          child: InkWell(
            onTap: (() => test(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama Lengkap",
                    overflow: TextOverflow.ellipsis, style: CustomFont.bold12),
                Text("Surabaya", style: CustomFont.regular12),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: CustomColor.blueColor,
                          size: 15,
                        ),
                        Text(
                          "Cold",
                          style: CustomFont.regular10,
                        ),
                      ],
                    ),
                    SpacerWidth(w: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: CustomColor.goldColor,
                          size: 15,
                        ),
                        Text(
                          "Warm",
                          style: CustomFont.regular10,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SpacerWidth(w: 10),
        SizedBox(
          // width: CustomScreen(context).width / 3.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  test(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/phone-solid.svg",
                    height: 20,
                  ),
                ),
              ),
              SpacerWidth(w: 5),
              GestureDetector(
                onTap: () {
                  test(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/envelope-solid.svg",
                    height: 20,
                  ),
                ),
              ),
              SpacerWidth(w: 5),
              GestureDetector(
                onTap: () {
                  test(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/whatsapp.svg",
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
