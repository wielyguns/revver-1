// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/snackbar.dart';
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
  bool isDream = false;

  int id;
  int user_id;
  String target_title;
  int target_point;
  DateTime target_date;
  String target_description;
  String created_at;
  String updated_at;
  DateTime target_date_sponsor;
  String kanan;
  String kiri;
  String sponsor_count;
  int pair;
  int price_per_pair;
  int price_per_sponsor;
  int sponsor;

  double totalPair;

  double kiriLeft;
  double kananLeft;
  double sponsorLeft;

  double kiriPerDay;
  double kananPerDay;
  double sponsorPerDay;

  int percentage;
  List<g.Goal> goal = [];
  String defDM = 'Day';

  DateTime dnow = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
  Duration duration;
  String tdate = "0";
  Duration durationS;
  String tdateS = "0";

  getData() async {
    if (!mounted) return;
    setState(() {
      isDream = false;
      isLoad = true;
      goal.clear();
    });
    await getGoal().then((val) {
      if (val['status'] == 200) {
        if (val['data'] == null) {
          nullValue();
        } else {
          setState(() {
            id = val['data']['id'];
            target_title = val['data']['target_title'];
            target_point = val['data']['target_point'];
            target_date =
                DateFormat('yyyy-MM-dd').parse(val['data']['target_date']);
            target_description = val['data']['target_description'];
            created_at = val['data']['created_at'];
            updated_at = val['data']['updated_at'];
            target_date_sponsor = DateFormat('yyyy-MM-dd')
                .parse(val['data']['target_date_sponsor']);
            kanan = val['data']['kanan'];
            kiri = val['data']['kiri'];
            sponsor_count = val['data']['sponsor_count'];
            pair = val['data']['pair'];
            price_per_pair = val['data']['price_per_pair'];
            price_per_sponsor = val['data']['price_per_sponsor'];
            sponsor = val['data']['sponsor'];

            duration = target_date.difference(dnow);
            tdate = duration.inDays.toString();

            durationS = target_date_sponsor.difference(dnow);
            tdateS = durationS.inDays.toString();

            for (var data in val['data']['goal_history'] as List) {
              goal.add(g.Goal.fromJson(jsonEncode(data)));
            }
            calculate();
          });
        }
      }
      if (val['status'] == 500) {
        nullValue();
      }
    });
  }

  calculate() async {
    setState(() {
      totalPair = target_point / price_per_pair;
      sponsorLeft = (totalPair * 2) * 0.005;
      kiriLeft = totalPair - int.parse(kiri);
      kananLeft = totalPair - int.parse(kanan);
      kiriPerDay = kiriLeft / int.parse(tdate);
      kananPerDay = kananLeft / int.parse(tdate);
      sponsorPerDay = sponsorLeft / int.parse(tdateS);
      kiriPerDay = double.parse(kiriPerDay.toStringAsFixed(0));
      kananPerDay = double.parse(kananPerDay.toStringAsFixed(0));
      sponsorPerDay = double.parse(sponsorPerDay.toStringAsFixed(0));
      isDream = true;
      isLoad = false;
    });
  }

  nullValue() {
    setState(() {
      id = null;
      target_title = null;
      target_point = null;
      target_description = null;
      target_date = dnow;
      percentage = 0;
      goal = [];
      duration = target_date.difference(dnow);
      tdate = duration.inDays.toString();
      isLoad = false;
    });
  }

  callbackSD() {
    if (!GoRouter.of(context).location.contains("set-dream")) {
      getData();
      GoRouter.of(context).removeListener(callbackSD);
    }
  }

  callbackRP() {
    if (!GoRouter.of(context).location.contains("record-progress")) {
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => GoRouter.of(context).pop(),
        ),
        actions: [
          InkWell(
            onTap: () {
              GoRouter.of(context).push('/set-dream');
              GoRouter.of(context).addListener(callbackSD);
            },
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                'assets/svg/pen-to-square-solid.svg',
                height: 20,
                color: CustomColor.brownColor,
              ),
            ),
          )
        ],
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  // SpacerHeight(h: 80),
                  // Text(
                  //   "Goals",
                  //   style:
                  //       CustomFont(CustomColor.brownColor, 20, FontWeight.w600)
                  //           .font,
                  // ),
                  SpacerHeight(
                      h: MediaQuery.of(context).padding.top +
                          kToolbarHeight +
                          20),
                  Container(
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).padding.top + kToolbarHeight) -
                        kBottomNavigationBarHeight -
                        90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: CustomColor.brownColor,
                      image: DecorationImage(
                        image: AssetImage("assets/img/revver-bg-1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Goals",
                          style: CustomFont(
                                  CustomColor.whiteColor, 26, FontWeight.w600)
                              .font,
                        ),
                        radialGauge(),
                        Text(
                          target_title ??= "Your Dream",
                          style: CustomFont(
                                  CustomColor.whiteColor, 22, FontWeight.w700)
                              .font,
                        ),
                        Text(
                          "Deadline in $tdate Days",
                          style: CustomFont(
                                  CustomColor.brownColor, 16, FontWeight.w400)
                              .font,
                        ),
                      ],
                    ),
                  ),
                  // Divider(
                  //   thickness: 2,
                  //   color: CustomColor.brownColor,
                  //   height: 40,
                  // ),
                  SpacerHeight(h: 55),
                  // Text(
                  //   "Target jaringan: 2800 kanan | 2800 kiri",
                  //   style:
                  //       CustomFont(CustomColor.blackColor, 12, FontWeight.w300)
                  //           .font,
                  // ),
                  // SpacerHeight(h: 20),
                  // Text(
                  //   "Perhitungan dibawah hanya diambil dari bonus referral (Sponsor):",
                  //   style:
                  //       CustomFont(CustomColor.blackColor, 12, FontWeight.w300)
                  //           .font,
                  // ),
                  Text("Current Kiri: $kiri"),
                  Text("Current Kanan: $kanan"),
                  Text("Current Sponsor: $sponsor_count"),
                  Text(""),
                  Text("Total Pair: $totalPair"),
                  Text("Sisa Kiri: $kiriLeft"),
                  Text("Sisa Kanan: $kananLeft"),
                  Text("Sisa Sponsor: $sponsorLeft"),
                  Text(""),
                  Text("Sisa Target Date Sponsor: $tdateS"),
                  Text(""),
                  Text("Min Pair per Day (Kiri): $kiriPerDay"),
                  Text("Min Pair per Day (Kanan): $kananPerDay"),
                  Text("Min Sponsor per Day : $sponsorPerDay"),

                  // SpacerHeight(h: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     SizedBox(
                  //       width: CustomScreen(context).width / 3,
                  //       child: StringDropdown(
                  //         title: '',
                  //         list: ['Day', 'Month'],
                  //         value: defDM,
                  //         callback: (val) {
                  //           setState(() {
                  //             defDM = val;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SpacerHeight(h: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Progress History",
                  //       style: CustomFont(
                  //               CustomColor.brownColor, 20, FontWeight.w700)
                  //           .font,
                  //     ),
                  //     // TextButton(
                  //     //     onPressed: () {},
                  //     //     style: TextButton.styleFrom(
                  //     //         padding: EdgeInsets.zero,
                  //     //         minimumSize: Size(50, 30),
                  //     //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //     //         alignment: Alignment.centerLeft),
                  //     //     child: Text(
                  //     //       "Reset Progress",
                  //     //       style: CustomFont(
                  //     //               CustomColor.brownColor, 12, FontWeight.w400)
                  //     //           .font,
                  //     //     )),
                  //   ],
                  // ),
                  SpacerHeight(h: 20),
                  (goal.isEmpty)
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 20, top: 20),
                          child: Text("No Record Progress!"),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: goal.length,
                          itemBuilder: ((context, index) {
                            g.Goal gl = goal[index];
                            String kiri = gl.kiri.toString();
                            String kanan = gl.kanan.toString();
                            String sponsor = gl.sponsor.toString();
                            return Column(
                              children: [
                                Slidable(
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (val) async {
                                          await deleteRecordProgress(gl.id)
                                              .then((val) {
                                            if (val['status'] == 200) {
                                              customSnackBar(context, false,
                                                  val['status'].toString());
                                              getData();
                                            } else {
                                              customSnackBar(context, true,
                                                  val['status'].toString());
                                            }
                                          });
                                        },
                                        backgroundColor:
                                            CustomColor.backgroundColor,
                                        foregroundColor: CustomColor.brownColor,
                                        label: "Delete Record",
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            color: CustomColor.brownColor,
                                            size: 16,
                                          ),
                                          SpacerWidth(w: 10),
                                          Text(
                                            "Ki: $kiri | Ka: $kanan | Sponsor: $sponsor",
                                            style: CustomFont(
                                                    CustomColor.blackColor,
                                                    14,
                                                    FontWeight.w600)
                                                .font,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: CustomColor.oldGreyColor,
                                            size: 12,
                                          ),
                                          SpacerWidth(w: 5),
                                          Text(
                                            gl.converted_date,
                                            style: CustomFont(
                                                    CustomColor.oldGreyColor,
                                                    9,
                                                    FontWeight.w300)
                                                .font,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 30,
                                  thickness: 1,
                                  color: CustomColor.oldGreyColor,
                                ),
                              ],
                            );
                          }),
                        ),
                ],
              ),
            ),
      bottomNavigationBar: (!isDream)
          ? SizedBox()
          : Container(
              color: CustomColor.backgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              child: CustomButton(
                title: "Record Progress",
                func: () async {
                  GoRouter.of(context).push("/record-progress/$id");
                  GoRouter.of(context).addListener(callbackRP);
                },
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
            thicknessUnit: GaugeSizeUnit.factor,
            thickness: 0.15,
            color: CustomColor.whiteColor.withOpacity(0.2),
          ),
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                positionFactor: 0.1,
                widget: CircleAvatar(
                  radius: MediaQuery.of(context).size.width - 300,
                  backgroundImage: AssetImage("assets/img/revver-bg.jpg"),
                  child: Text(
                    percentage.toString() + "%",
                    style:
                        CustomFont(CustomColor.whiteColor, 32, FontWeight.w600)
                            .font,
                  ),
                )),
          ],
          pointers: <GaugePointer>[
            RangePointer(
                value: 10,
                cornerStyle: CornerStyle.bothCurve,
                enableAnimation: true,
                animationDuration: 500,
                sizeUnit: GaugeSizeUnit.factor,
                color: CustomColor.whiteColor,
                width: 0.15),
          ],
        ),
      ],
    );
  }
}
