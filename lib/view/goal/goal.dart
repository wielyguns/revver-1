// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/header.dart';
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

  double percentage;
  List<g.Goal> goal = [];
  String defDM = 'Day';

  DateTime dnow = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
  Duration duration;
  String tdate = "0";
  Duration durationS;
  String tdateS = "0";

  XFile image;
  final ImagePicker picker = ImagePicker();
  String avatar;

  getImage(ImageSource media) async {
    var img =
        await picker.pickImage(source: media, maxHeight: 480, maxWidth: 640);
    _onLoading();
    if (img == null) {
      Navigator.pop(context);
    } else {
      await postGoalImage(id.toString(), img.path, img.name).then((val) {
        if (val == 200) {
          getData();
          customSnackBar(context, false, val.toString());
          Navigator.pop(context);
        } else {
          customSnackBar(context, true, val.toString());
          Navigator.pop(context);
        }
      });
    }
  }

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
            avatar = val['data']['image'];

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
      kiriLeft = double.parse(kiriLeft.toStringAsFixed(0));
      kananLeft = double.parse(kananLeft.toStringAsFixed(0));
      sponsorLeft = double.parse(sponsorLeft.toStringAsFixed(0));
      kiriPerDay = double.parse(kiriPerDay.toStringAsFixed(0));
      kananPerDay = double.parse(kananPerDay.toStringAsFixed(0));
      sponsorPerDay = double.parse(sponsorPerDay.toStringAsFixed(0));
      double xPercentage = ((pair + sponsor) / target_point) * 100;
      percentage = double.parse(xPercentage.toStringAsFixed(0));
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

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    getData();
    setState(() {});
  }

  @override
  void initState() {
    Timer.run(() {
      introduction();
    });

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: CustomHeader(
        title: "Goals",
        svgName: "pen-to-square-solid.svg",
        route: "/set-dream",
        callback: callbackSD,
        isPop: true,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : RefreshIndicator(
              onRefresh: _pullRefresh,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    SpacerHeight(h: 20),
                    Container(
                      height: MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).padding.top +
                              kToolbarHeight) -
                          kBottomNavigationBarHeight -
                          150,
                      decoration: BoxDecoration(
                        color: Color(0xFF3A515F),
                        borderRadius: BorderRadius.circular(20),
                        // color: CustomColor.brownColor,
                        image: DecorationImage(
                          image: AssetImage("assets/img/revver-bg.jpg"),
                          opacity: 0.1,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: image != null
                                ? CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(image.path)),
                                    radius: CustomScreen(context).width - 305,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(avatar ??=
                                        "https://wallpaperaccess.com/full/733834.png"),
                                    radius: CustomScreen(context).width - 305,
                                  ),
                          ),
                          radialGauge(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    target_title ??= "Your Dream",
                                    style: CustomFont(CustomColor.whiteColor,
                                            22, FontWeight.w700)
                                        .font,
                                  ),
                                  Text(
                                    "Deadline in $tdate Days",
                                    style: CustomFont(CustomColor.brownColor,
                                            16, FontWeight.w400)
                                        .font,
                                  ),
                                  SizedBox(height: 5),
                                  InkWell(
                                    onTap: (() {
                                      introduction();
                                    }),
                                    child: Icon(
                                      Icons.info,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SpacerHeight(h: 20),
                    (isDream)
                        ? Container(
                            decoration: BoxDecoration(
                              color: CustomColor.backgroundColor,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 13,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Text(
                                  "Current",
                                  style: CustomFont(CustomColor.brownColor, 16,
                                          FontWeight.w700)
                                      .font,
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Kiri",
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  12,
                                                  FontWeight.w400)
                                              .font,
                                        ),
                                        Text(
                                          kiri ??= "",
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  14,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Kanan",
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  12,
                                                  FontWeight.w400)
                                              .font,
                                        ),
                                        Text(
                                          kanan ??= "",
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  14,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Sponsor",
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  12,
                                                  FontWeight.w400)
                                              .font,
                                        ),
                                        Text(
                                          sponsor_count ??= "",
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  14,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          )
                        : SizedBox(),
                    (isDream) ? SpacerHeight(h: 20) : SpacerHeight(h: 0),
                    (isDream)
                        ? Container(
                            decoration: BoxDecoration(
                              color: CustomColor.backgroundColor,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 13,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Pair ",
                                      style: CustomFont(CustomColor.brownColor,
                                              16, FontWeight.w700)
                                          .font,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      totalPair.toString(),
                                      style: CustomFont(CustomColor.blackColor,
                                              16, FontWeight.w700)
                                          .font,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Kiri",
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  12,
                                                  FontWeight.w400)
                                              .font,
                                        ),
                                        Text(
                                          kiriLeft.toString(),
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  14,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Kanan",
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  12,
                                                  FontWeight.w400)
                                              .font,
                                        ),
                                        Text(
                                          kananLeft.toString(),
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  14,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Sponsor",
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  12,
                                                  FontWeight.w400)
                                              .font,
                                        ),
                                        Text(
                                          sponsorLeft.toString(),
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  14,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          )
                        : SizedBox(),
                    (isDream) ? SpacerHeight(h: 20) : SpacerHeight(h: 0),
                    (isDream)
                        ? Container(
                            decoration: BoxDecoration(
                              color: CustomColor.backgroundColor,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 13,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Text(
                                  "Sisa Target Date Sponsor",
                                  style: CustomFont(CustomColor.brownColor, 16,
                                          FontWeight.w700)
                                      .font,
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      tdateS,
                                      style: CustomFont(CustomColor.blackColor,
                                              16, FontWeight.w700)
                                          .font,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          )
                        : SizedBox(),
                    (isDream) ? SpacerHeight(h: 20) : SpacerHeight(h: 0),
                    (isDream)
                        ? Container(
                            decoration: BoxDecoration(
                              color: CustomColor.backgroundColor,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 13,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                Text(
                                  "Min Pair per Day",
                                  style: CustomFont(CustomColor.brownColor, 16,
                                          FontWeight.w700)
                                      .font,
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Kiri",
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  12,
                                                  FontWeight.w400)
                                              .font,
                                        ),
                                        Text(
                                          kiriPerDay.toString(),
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  14,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Kanan",
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  12,
                                                  FontWeight.w400)
                                              .font,
                                        ),
                                        Text(
                                          kananPerDay.toString(),
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  14,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Sponsor",
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  12,
                                                  FontWeight.w400)
                                              .font,
                                        ),
                                        Text(
                                          sponsorPerDay.toString(),
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  14,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          )
                        : SizedBox(),
                    (isDream) ? SpacerHeight(h: 40) : SpacerHeight(h: 0),
                    (isDream)
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Progress History",
                                    style: CustomFont(CustomColor.brownColor,
                                            16, FontWeight.w700)
                                        .font,
                                  ),
                                ],
                              ),
                              SpacerHeight(h: 20),
                              (goal.isEmpty)
                                  ? Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 20, top: 20),
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
                                                    onPressed: (val) {
                                                      deleteConfirmation(gl.id);
                                                    },
                                                    backgroundColor: CustomColor
                                                        .backgroundColor,
                                                    foregroundColor:
                                                        CustomColor.brownColor,
                                                    label: "Delete Record",
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                          "assets/svg/new-gold.svg"),
                                                      SpacerWidth(w: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "My Progress",
                                                            style: CustomFont(
                                                                    CustomColor
                                                                        .blackColor,
                                                                    14,
                                                                    FontWeight
                                                                        .w600)
                                                                .font,
                                                          ),
                                                          Text(
                                                            "Ki: $kiri | Ka: $kanan | Sponsor: $sponsor",
                                                            style: CustomFont(
                                                                    CustomColor
                                                                        .oldGreyColor,
                                                                    9,
                                                                    FontWeight
                                                                        .w500)
                                                                .font,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.calendar_month,
                                                        color: CustomColor
                                                            .oldGreyColor,
                                                        size: 12,
                                                      ),
                                                      SpacerWidth(w: 5),
                                                      Text(
                                                        gl.converted_date,
                                                        style: CustomFont(
                                                                CustomColor
                                                                    .oldGreyColor,
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
                          )
                        : Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: IconTextButton(
                                  title: "Buat Mimpi",
                                  buttonColor: CustomColor.brownColor,
                                  func: () {
                                    GoRouter.of(context).push("/set-dream");
                                    GoRouter.of(context)
                                        .addListener(callbackSD);
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          )
                  ],
                ),
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
    return InkWell(
      onTap: (() {
        getImage(ImageSource.gallery);
      }),
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.7,
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                angle: 270,
                positionFactor: 0.1,
                widget: Text(
                  percentage.toString() + "%",
                  style: CustomFont(CustomColor.whiteColor, 32, FontWeight.w600)
                      .font,
                ),
              ),
            ],
            axisLineStyle: AxisLineStyle(
              thicknessUnit: GaugeSizeUnit.factor,
              thickness: 0.25,
              color: CustomColor.oldGreyColor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                  value: percentage,
                  cornerStyle: CornerStyle.bothCurve,
                  enableAnimation: true,
                  animationDuration: 500,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: CustomColor.whiteColor,
                  width: 0.25),
            ],
          ),
        ],
      ),
    );
  }

  deleteConfirmation(glid) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peringatan'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah anda yakin ingin menghapus Progress ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Tidak',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () async {
                await deleteRecordProgress(glid).then((val) {
                  if (val['status'] == 200) {
                    customSnackBar(context, false, "Sukses");
                    Navigator.of(context).pop();
                    getData();
                  } else {
                    customSnackBar(context, true, "Gagal");
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }

  introduction() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Introduction'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tata Cara ...'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Tutup',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          height: CustomScreen(context).height,
          width: CustomScreen(context).width,
          color: Colors.black.withOpacity(0.1),
          child: Center(
              child: CupertinoActivityIndicator(
            color: CustomColor.whiteColor,
          )),
        );
      },
    );
  }
}
