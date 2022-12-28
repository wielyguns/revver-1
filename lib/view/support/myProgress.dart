import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyProgress extends StatefulWidget {
  const MyProgress({Key key}) : super(key: key);

  @override
  State<MyProgress> createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                    thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    positionFactor: 0.1,
                    widget: Text(
                      "%",
                      style: CustomFont(
                              CustomColor.oldGreyColor, 20, FontWeight.w700)
                          .font,
                    ),
                  ),
                ],
                pointers: <GaugePointer>[
                  RangePointer(
                      value: 20,
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
            "Journey To Champion",
            style: CustomFont(CustomColor.blackColor, 18, FontWeight.w600).font,
          ),
          SpacerHeight(h: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: ((context, index) {
                return ExpandableNotifier(
                  child: Column(
                    children: [
                      Expandable(
                        collapsed: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Benefits",
                                    style: CustomFont(CustomColor.blackColor,
                                            14, FontWeight.w400)
                                        .font),
                                ExpandableButton(
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 2,
                              color: CustomColor.brownColor.withOpacity(0.5),
                            )
                          ],
                        ),
                        expanded: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Benefits",
                                    style: CustomFont(CustomColor.blackColor,
                                            14, FontWeight.w400)
                                        .font),
                                ExpandableButton(
                                  child: Icon(
                                    Icons.remove,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 2,
                              color: CustomColor.brownColor.withOpacity(0.5),
                            ),
                            Text(
                                "aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa"),
                            SpacerHeight(h: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          SpacerHeight(h: 20),
        ],
      ),
    );
  }
}
