// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/goal.dart';
import 'package:revver/globals.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:revver/model/goal.dart' as g;

class Goal extends StatefulWidget {
  const Goal({Key key}) : super(key: key);

  @override
  State<Goal> createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  bool isLoad = true;
  String target_title;
  int target_point;
  DateTime target_date;
  String target_description;
  int percentage = 0;
  List<g.Goal> goal = [];
  List<g.ReferralRate> rrate = [];

  DateTime dnow = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
  Duration duration;
  String tdate = "0";

  getData() async {
    setState(() {
      isLoad = true;
    });
    await getReferralRate().then((val) async {
      setState(() {
        rrate = val;
      });
      await getGoal().then((val) {
        if (val['status'] == 200) {
          setState(() {
            target_title = val['data']['target_title'];
            target_point = val['data']['target_point'];
            target_date =
                DateFormat('yyyy-MM-dd').parse(val['data']['target_date']);
            target_description = val['data']['target_description'];
            percentage = val['data']['percentage'];
            for (var data in val['data']['goal_history'] as List) {
              goal.add(g.Goal.fromJson(jsonEncode(data)));
            }
            duration = target_date.difference(dnow);
            tdate = duration.inDays.toString();
            isLoad = false;
          });
        } else {
          setState(() {
            target_title = "";
            target_point = 0;
            target_date = dnow;
            target_description = "";
            percentage = 0;
            goal = [];
            duration = target_date.difference(dnow);
            tdate = duration.inDays.toString();
            isLoad = false;
          });
        }
      });
    });
  }

  callbackSD() {
    if (!GoRouter.of(context).location.contains("/set-dream")) {
      getData();
      GoRouter.of(context).removeListener(callbackSD);
    }
  }

  callbackRP() {
    if (!GoRouter.of(context).location.contains("/record-progress")) {
      getData();
      GoRouter.of(context).removeListener(callbackRP);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Goals",
        isPop: true,
        svgName: "pen-to-square-solid.svg",
        route: '/set-dream',
        callback: callbackSD(),
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
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
                            thicknessUnit: GaugeSizeUnit.factor,
                            thickness: 0.15),
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            positionFactor: 0.1,
                            widget: Text(
                              percentage.toString() + "%",
                              style: CustomFont(CustomColor.oldGreyColor, 20,
                                      FontWeight.w700)
                                  .font,
                            ),
                          ),
                        ],
                        pointers: <GaugePointer>[
                          RangePointer(
                              value: percentage.toDouble(),
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
                    target_title ??= "Your Dream",
                    style:
                        CustomFont(CustomColor.blackColor, 20, FontWeight.w700)
                            .font,
                  ),
                  Text(
                    "Deadline in $tdate Days",
                    style:
                        CustomFont(CustomColor.blackColor, 12, FontWeight.w300)
                            .font,
                  ),
                  Divider(
                    thickness: 2,
                    color: CustomColor.brownColor,
                    height: 40,
                  ),
                  Text(
                    "Target jaringan: 2800 kanan | 2800 kiri",
                    style:
                        CustomFont(CustomColor.blackColor, 12, FontWeight.w300)
                            .font,
                  ),
                  SpacerHeight(h: 10),
                  Text(
                    "Perhitungan dibawah hanya diambil dari bonus referral (Sponsor):",
                    textAlign: TextAlign.center,
                    style:
                        CustomFont(CustomColor.blackColor, 12, FontWeight.w300)
                            .font,
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
                                style: CustomFont(CustomColor.whiteColor, 12,
                                        FontWeight.w700)
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
                                    style: CustomFont(CustomColor.blackColor,
                                            18, FontWeight.w700)
                                        .font,
                                  ),
                                  SpacerWidth(w: 10),
                                  Text(
                                    "per Bulan",
                                    style: CustomFont(CustomColor.blackColor,
                                            16, FontWeight.w300)
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Progress History",
                        style: CustomFont(
                                CustomColor.brownColor, 20, FontWeight.w700)
                            .font,
                      ),
                      // TextButton(
                      //     onPressed: () {},
                      //     style: TextButton.styleFrom(
                      //         padding: EdgeInsets.zero,
                      //         minimumSize: Size(50, 30),
                      //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //         alignment: Alignment.centerLeft),
                      //     child: Text(
                      //       "Reset Progress",
                      //       style: CustomFont(
                      //               CustomColor.brownColor, 12, FontWeight.w400)
                      //           .font,
                      //     )),
                    ],
                  ),
                  SpacerHeight(h: 10),
                  (goal.isEmpty)
                      ? Text("No Record Progress!")
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: goal.length,
                          itemBuilder: ((context, index) {
                            g.Goal gl = goal[index];
                            List<g.ReferralRate> x = rrate
                                .where((e) => e.id == gl.referral_rate_id)
                                .toList();
                            List<g.ReferralRate> y = x;
                            String rateName = y[0].name;
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.circle),
                                        SpacerWidth(w: 10),
                                        Text(
                                          gl.qty.toString() + " $rateName",
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  14,
                                                  FontWeight.w700)
                                              .font,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      gl.updated_at,
                                      style: CustomFont(
                                              CustomColor.oldGreyColor,
                                              9,
                                              FontWeight.w300)
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
          func: () async {
            GoRouter.of(context).push("/record-progress");
            callbackRP();
          },
        ),
      ),
    );
  }
}
