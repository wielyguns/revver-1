// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/support.dart';
import 'package:revver/globals.dart';

class DownlineDetail extends StatefulWidget {
  DownlineDetail({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<DownlineDetail> createState() => _DownlineDetailState();
}

class _DownlineDetailState extends State<DownlineDetail> {
  bool isLoad = true;
  int id;
  String name;
  String photo;
  String stageName;

  //Current Task
  bool current_task = false;
  int current_task_id;
  String current_task_title;
  String current_task_content;
  int current_task_status;

  String sStatus;

  getData(wid) async {
    if (!mounted) return;
    setState(() {
      isLoad = true;
    });
    await getSupportMemberDetail(wid).then((val) {
      if (val['data']['current_task'] == null) {
        setState(() {
          current_task = false;
          id = val['data']['id'];
          name = val['data']['name'];
          photo = val['data']['photo'];
          stageName = val['data']['stage']['name'];
          isLoad = false;
        });
      } else {
        setState(() {
          current_task = true;
          id = val['data']['id'];
          name = val['data']['name'];
          photo = val['data']['photo'];
          stageName = val['data']['stage']['name'];
          current_task_id = val['data']['current_task']['id'];
          current_task_title =
              val['data']['current_task']['indicator']['title'];
          current_task_content =
              val['data']['current_task']['indicator']['content'];
          current_task_status =
              val['data']['current_task']['indicator']['status'];
          if (current_task_status == 0) {
            sStatus = "Unfinish";
          }
          if (current_task_status == 1) {
            sStatus = "Pending";
          }
          if (current_task_status == 2) {
            sStatus = "Finish";
          }
          isLoad = false;
        });
      }
    });
  }

  @override
  void initState() {
    getData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(),
        centerTitle: true,
        title: Image.asset(
          "assets/img/revver-horizontal.png",
          width: CustomScreen(context).width / 3,
        ),
        backgroundColor: CustomColor.backgroundColor,
        elevation: 0,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SpacerHeight(h: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: [
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/img/background-resize.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Support",
                              style: CustomFont(CustomColor.whiteColor, 32,
                                      FontWeight.w600)
                                  .font,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SpacerHeight(h: 120),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SpacerWidth(w: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    color: CustomColor.whiteColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  height: 80,
                                  width: 80,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    fit: StackFit.expand,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(photo ??=
                                            "https://wallpaperaccess.com/full/733834.png"),
                                      ),
                                    ],
                                  ),
                                ),
                                SpacerWidth(w: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: CustomFont(CustomColor.brownColor,
                                              14, FontWeight.bold)
                                          .font,
                                    ),
                                    Text(
                                      stageName,
                                      style: CustomFont(
                                              CustomColor.oldGreyColor,
                                              12,
                                              null)
                                          .font,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  // SpacerHeight(h: 10),
                  // Text(
                  //   name,
                  //   style:
                  //       CustomFont(CustomColor.brownColor, 20, FontWeight.w600)
                  //           .font,
                  // ),
                  // SpacerHeight(h: 5),
                  // Text(
                  //   stageName,
                  //   style: CustomFont(
                  //           CustomColor.oldGreyColor, 13, FontWeight.w400)
                  //       .font,
                  // ),
                  SpacerHeight(h: 20),
                  (current_task)
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ExpandableNotifier(
                            initialExpanded: true,
                            child: Column(
                              children: [
                                Expandable(
                                  collapsed: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(current_task_title,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(current_task_title,
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
                                      Html(data: current_task_content),
                                      SpacerHeight(h: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Status: $sStatus",
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
                                              onPressed: (current_task_status ==
                                                      1)
                                                  ? () async {
                                                      await patchSupportMember(
                                                              current_task_id)
                                                          .then((val) {
                                                        if (val['status'] ==
                                                            200) {
                                                          getData(widget.id);
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
                                                    "Review Task",
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
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
    );
  }
}

// Stack(
//   children: [
//     Container(
//       height: 140,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(
//               'assets/img/background-resize.png'),
//           fit: BoxFit.cover,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Center(
//         child: Text(
//           "My Downline",
//           style: CustomFont(CustomColor.whiteColor, 32,
//                   FontWeight.w600)
//               .font,
//         ),
//       ),
//     ),
//     Column(
//       children: [
//         SpacerHeight(h: 100),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: CustomColor.whiteColor,
//                 borderRadius: BorderRadius.circular(100),
//               ),
//               padding: EdgeInsets.all(5),
//               height: 80,
//               width: 80,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 fit: StackFit.expand,
//                 children: [
//                   CircleAvatar(
//                     backgroundImage: NetworkImage(photo ??=
//                         "https://wallpaperaccess.com/full/733834.png"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     )
//   ],
// ),