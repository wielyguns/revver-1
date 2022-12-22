import 'package:flutter/material.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Goal extends StatefulWidget {
  const Goal({Key key}) : super(key: key);

  @override
  State<Goal> createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Goals",
        isPop: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  showLabels: false,
                  showTicks: false,
                  startAngle: 270,
                  endAngle: 270,
                  radiusFactor: 0.7,
                  axisLineStyle: AxisLineStyle(
                      thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      positionFactor: 0.1,
                      widget: Text(
                        "50%",
                        style: CustomFont(
                                CustomColor.oldGreyColor, 20, FontWeight.w700)
                            .font,
                      ),
                    ),
                  ],
                  pointers: <GaugePointer>[
                    RangePointer(
                        value: 50,
                        cornerStyle: CornerStyle.bothCurve,
                        enableAnimation: true,
                        animationDuration: 3000,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: CustomColor.brownColor,
                        width: 0.15),
                  ],
                ),
              ],
            ),
            Text(
              "Your Dream",
              style:
                  CustomFont(CustomColor.blackColor, 20, FontWeight.w700).font,
            ),
            Text(
              "Deadline in 2 Month",
              style:
                  CustomFont(CustomColor.blackColor, 12, FontWeight.w300).font,
            ),
            Divider(
              thickness: 2,
              color: CustomColor.brownColor,
              height: 40,
            ),
            Text(
              "Target jaringan: 2800 kanan | 2800 kiri",
              style:
                  CustomFont(CustomColor.blackColor, 12, FontWeight.w300).font,
            ),
            SpacerHeight(h: 10),
            Text(
              "Perhitungan dibawah hanya diambil dari bonus referral (Sponsor):",
              textAlign: TextAlign.center,
              style:
                  CustomFont(CustomColor.blackColor, 12, FontWeight.w300).font,
            ),
            SpacerHeight(h: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: ((context, index) {
                return Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    Divider(
                      endIndent: 5,
                      thickness: 10,
                      color: Colors.red,
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          "or",
                          style: CustomFont(
                                  CustomColor.whiteColor, 12, FontWeight.w700)
                              .font,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "1000 Platinum",
                              style: CustomFont(CustomColor.blackColor, 18,
                                      FontWeight.w700)
                                  .font,
                            ),
                            SpacerWidth(w: 10),
                            Text(
                              "per Bulan",
                              style: CustomFont(CustomColor.blackColor, 18,
                                      FontWeight.w300)
                                  .font,
                            )
                          ],
                        ),
                        SpacerHeight(h: 35),
                      ],
                    ),
                  ],
                );
              }),
            ),
            SpacerHeight(h: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Progress History",
                  style: CustomFont(CustomColor.brownColor, 20, FontWeight.w700)
                      .font,
                ),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                    child: Text(
                      "Reset Progress",
                      style: CustomFont(
                              CustomColor.brownColor, 12, FontWeight.w400)
                          .font,
                    )),
              ],
            ),
            SpacerHeight(h: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.circle),
                            SpacerWidth(w: 10),
                            Text(
                              "1 Gold",
                              style: CustomFont(CustomColor.blackColor, 14,
                                      FontWeight.w700)
                                  .font,
                            ),
                          ],
                        ),
                        Text(
                          "17-10-2022",
                          style: CustomFont(
                                  CustomColor.oldGreyColor, 10, FontWeight.w300)
                              .font,
                        ),
                      ],
                    ),
                    SpacerHeight(h: 5),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: CustomColor.backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CustomButton(
          title: "Record Progress",
          func: () async {},
        ),
      ),
    );
  }
}
