import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';

import 'package:revver/controller/support.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/support.dart';

class MyDownline extends StatefulWidget {
  const MyDownline({Key key}) : super(key: key);

  @override
  State<MyDownline> createState() => _MyDownlineState();
}

class _MyDownlineState extends State<MyDownline> {
  String image;
  bool isLoad = true;
  List<Member> member = [];
  getData() async {
    if (!mounted) return;
    await getSupportMember().then((val) {
      setState(() {
        member = val;
        isLoad = false;
      });
    });
  }

  callback() {
    if (!GoRouter.of(context).location.contains("downline-detail")) {
      getData();
      GoRouter.of(context).removeListener(callback);
    }
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
                  SpacerHeight(h: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: (member.isEmpty)
                        ? Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Member Kosong!",
                              style: CustomFont(CustomColor.blackColor, 16,
                                      FontWeight.w600)
                                  .font,
                            ),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: member.length,
                            itemBuilder: ((context, index) {
                              Member mem = member[index];
                              String id = mem.id.toString();
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (() {
                                      GoRouter.of(context)
                                          .push('/downline-detail/$id');
                                      GoRouter.of(context)
                                          .addListener(callback);
                                    }),
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: CustomColor.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 0,
                                            blurRadius: 13,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          SpacerWidth(w: 10),
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: CustomColor.blackColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: (mem.avatar == null)
                                                    ? NetworkImage(
                                                        'https://wallpaperaccess.com/full/733834.png')
                                                    : NetworkImage(mem.avatar),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SpacerWidth(w: 10),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  mem.name ??= "",
                                                  style: CustomFont(
                                                          CustomColor
                                                              .blackColor,
                                                          14,
                                                          FontWeight.w600)
                                                      .font,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                Text(
                                                  mem.stage_name ??= "",
                                                  style: CustomFont(
                                                          CustomColor
                                                              .oldGreyColor,
                                                          12,
                                                          FontWeight.w600)
                                                      .font,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SpacerWidth(w: 10),
                                          (mem.current_task != "[]")
                                              ? Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: CustomColor.redColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Text(
                                                    "Review Needed",
                                                    style: CustomFont(
                                                            CustomColor
                                                                .whiteColor,
                                                            10,
                                                            FontWeight.w600)
                                                        .font,
                                                  ),
                                                )
                                              : SizedBox(),
                                          // Text(
                                          //   mem.stage_name ??= "",
                                          //   style: CustomFont(
                                          //           CustomColor.oldGreyColor,
                                          //           14,
                                          //           FontWeight.w600)
                                          //       .font,
                                          //   overflow: TextOverflow.ellipsis,
                                          //   maxLines: 2,
                                          // ),
                                          SpacerWidth(w: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SpacerHeight(h: 10),
                                ],
                              );
                            }),
                          ),
                  )
                ],
              ),
            ),
          );
  }
}
