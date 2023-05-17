// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/support.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/support.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyProgress extends StatefulWidget {
  const MyProgress({Key key}) : super(key: key);

  @override
  State<MyProgress> createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress> {
  bool isLoad = true;
  int id;
  String name;
  String priority;
  String badge_image;
  int status;
  List<Indicator> indicator = [];
  List<Indicator> finished = [];
  double y;

  getData() async {
    if (!mounted) return;
    setState(() {
      indicator.clear();
      isLoad = true;
    });
    await getSupport().then((val) {
      double x;
      setState(() {
        id = val['data']['id'];
        name = val['data']['name'];
        priority = val['data']['priority'];
        badge_image = val['data']['badge_image'];
        status = val['data']['status'];
        for (var data in val['data']['indicator'] as List) {
          indicator.add(Indicator.fromJson(jsonEncode(data)));
        }
        finished = indicator.where((e) => e.status == 2).toList();
        x = 100 / indicator.length;
        y = x * finished.length;
        isLoad = false;
      });
    });
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoad)
        ? Center(child: CupertinoActivityIndicator())
        : RefreshIndicator(
            onRefresh: _pullRefresh,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                    decoration: BoxDecoration(
                      color: CustomColor.blackColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        radialGauge(),
                        Text(
                          "Journey To Champion",
                          style: CustomFont(
                                  CustomColor.whiteColor, 18, FontWeight.w600)
                              .font,
                        ),
                        Text(
                          name,
                          style: CustomFont(
                                  CustomColor.oldGreyColor, 16, FontWeight.w600)
                              .font,
                        ),
                        SpacerHeight(h: 20),
                      ],
                    ),
                  ),
                  SpacerHeight(h: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: indicator.length,
                      itemBuilder: ((context, index) {
                        Indicator indi = indicator[index];
                        String status;
                        if (indi.status == 0) {
                          status = "Unfinish";
                        }
                        if (indi.status == 1) {
                          status = "Pending";
                        }
                        if (indi.status == 2) {
                          status = "Finish";
                        }
                        return ExpandableNotifier(
                          child: Column(
                            children: [
                              Expandable(
                                collapsed: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(indi.title,
                                            style: CustomFont(
                                                    CustomColor.blackColor,
                                                    16,
                                                    FontWeight.w600)
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
                                      color: CustomColor.brownColor
                                          .withOpacity(0.5),
                                    )
                                  ],
                                ),
                                expanded: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(indi.title,
                                            style: CustomFont(
                                                    CustomColor.blackColor,
                                                    16,
                                                    FontWeight.w600)
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
                                      color: CustomColor.brownColor
                                          .withOpacity(0.5),
                                    ),
                                    Html(data: indi.content),
                                    SpacerHeight(h: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Status: $status",
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  12,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: CupertinoButton(
                                            padding: EdgeInsets.all(1),
                                            onPressed: (indi.status == 0)
                                                ? () async {
                                                    await patchSupport(indi
                                                            .vital_indicator_progress_id)
                                                        .then((val) {
                                                      if (val['status'] ==
                                                          200) {
                                                        getData();
                                                      } else {
                                                        customSnackBar(
                                                            context,
                                                            true,
                                                            val['status']
                                                                .toString());
                                                      }
                                                    });
                                                  }
                                                : null,
                                            color: CustomColor.brownColor,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Finish Task",
                                                  style: CustomFont(
                                                          CustomColor
                                                              .whiteColor,
                                                          9,
                                                          FontWeight.w600)
                                                      .font,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
            ),
          );
  }

  radialGauge() {
    return SfRadialGauge(
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
                y.toInt().toString() +
                    "%\n" +
                    finished.length.toString() +
                    " / " +
                    indicator.length.toString(),
                style: CustomFont(CustomColor.brownColor, 32, FontWeight.w600)
                    .font,
                textAlign: TextAlign.center,
              ),
            ),
          ],
          pointers: <GaugePointer>[
            RangePointer(
                value: y,
                cornerStyle: CornerStyle.bothCurve,
                enableAnimation: true,
                animationDuration: 3000,
                sizeUnit: GaugeSizeUnit.factor,
                color: CustomColor.whiteColor,
                width: 0.15),
          ],
        ),
      ],
    );
  }
}
