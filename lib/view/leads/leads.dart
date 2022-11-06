import 'package:flutter/material.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class Leads extends StatefulWidget {
  Leads({Key key}) : super(key: key);

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
  double cold = 2;
  double warm = 1;
  double hot = 3;
  double converted = 4;

  double potential = 1;
  double avarage = 2;
  double underAvarage = 3;

  @override
  Widget build(BuildContext context) {
    double d = MediaQuery.of(context).size.width - 40;
    double allStats = cold + warm + hot + converted;
    double allScore = potential + avarage + underAvarage;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpacerHeight(h: 20),
              Text("Leads", style: CustomFont.heading24),
              SpacerHeight(h: 20),
              Text("Leads Overview", style: CustomFont.bold16),
              SpacerHeight(h: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: (d / allStats) * cold,
                      child: Divider(
                        color: CustomColor.blueColor,
                        thickness: 10,
                      ),
                    ),
                    SizedBox(
                      width: (d / allStats) * warm,
                      child: Divider(
                        color: CustomColor.goldColor,
                        thickness: 10,
                      ),
                    ),
                    SizedBox(
                      width: (d / allStats) * hot,
                      child: Divider(
                        color: CustomColor.brownColor,
                        thickness: 10,
                      ),
                    ),
                    SizedBox(
                      width: (d / allStats) * converted,
                      child: Divider(
                        color: CustomColor.greenColor,
                        thickness: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        style: CustomFont.regular12,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: CustomColor.goldColor,
                        size: 15,
                      ),
                      Text(
                        "Warm",
                        style: CustomFont.regular12,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: CustomColor.brownColor,
                        size: 15,
                      ),
                      Text(
                        "Hot",
                        style: CustomFont.regular12,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: CustomColor.greenColor,
                        size: 15,
                      ),
                      Text(
                        "Converted",
                        style: CustomFont.regular12,
                      ),
                    ],
                  ),
                ],
              ),
              SpacerHeight(h: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: (d / allScore) * potential,
                      child: Divider(
                        color: CustomColor.blueColor,
                        thickness: 10,
                      ),
                    ),
                    SizedBox(
                      width: (d / allScore) * avarage,
                      child: Divider(
                        color: CustomColor.brownColor,
                        thickness: 10,
                      ),
                    ),
                    SizedBox(
                      width: (d / allScore) * underAvarage,
                      child: Divider(
                        color: CustomColor.oldGreyColor,
                        thickness: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: CustomColor.blueColor,
                        size: 15,
                      ),
                      Text(
                        "Potential",
                        style: CustomFont.regular12,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: CustomColor.brownColor,
                        size: 15,
                      ),
                      Text(
                        "Avarage",
                        style: CustomFont.regular12,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: CustomColor.oldGreyColor,
                        size: 15,
                      ),
                      Text(
                        "Under Avarage",
                        style: CustomFont.regular12,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
