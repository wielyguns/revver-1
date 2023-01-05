import 'package:flutter/material.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class LeadsOverview extends StatefulWidget {
  LeadsOverview(
      {Key key,
      this.cold,
      this.avarage,
      this.converted,
      this.hot,
      this.potential,
      this.underAvarage,
      this.warm})
      : super(key: key);
  double cold;
  double warm;
  double hot;
  double converted;

  double potential;
  double avarage;
  double underAvarage;

  @override
  State<LeadsOverview> createState() => _LeadsOverviewState();
}

class _LeadsOverviewState extends State<LeadsOverview> {
  double allStats;
  double allScore;

  @override
  void initState() {
    super.initState();
    allStats = widget.cold + widget.warm + widget.hot + widget.converted;
    allScore = widget.potential + widget.avarage + widget.underAvarage;
  }

  @override
  Widget build(BuildContext context) {
    double d = MediaQuery.of(context).size.width - 80;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Leads Overview", style: CustomFont.bold16),
        // SpacerHeight(h: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: Row(
            children: [
              SizedBox(
                width: (d / allStats) * widget.cold,
                child: Divider(
                  color: CustomColor.blueColor,
                  thickness: 10,
                ),
              ),
              SizedBox(
                width: (d / allStats) * widget.warm,
                child: Divider(
                  color: CustomColor.brownColor,
                  thickness: 10,
                ),
              ),
              SizedBox(
                width: (d / allStats) * widget.hot,
                child: Divider(
                  color: CustomColor.redColor,
                  thickness: 10,
                ),
              ),
              SizedBox(
                width: (d / allStats) * widget.converted,
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
                  color: CustomColor.brownColor,
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
                  color: CustomColor.redColor,
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
                width: (d / allScore) * widget.potential,
                child: Divider(
                  color: CustomColor.blueColor,
                  thickness: 10,
                ),
              ),
              SizedBox(
                width: (d / allScore) * widget.avarage,
                child: Divider(
                  color: CustomColor.brownColor,
                  thickness: 10,
                ),
              ),
              SizedBox(
                width: (d / allScore) * widget.underAvarage,
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
    );
  }
}
