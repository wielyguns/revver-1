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

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoad)
        ? Center(child: CupertinoActivityIndicator())
        : SingleChildScrollView(
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
                            "Empty Member!",
                            style: CustomFont(
                                    CustomColor.blackColor, 16, FontWeight.w600)
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
                                  onTap: () => GoRouter.of(context)
                                      .push('/downline-detail/$id'),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: CustomColor.whiteColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
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
                                          child: Text(
                                            mem.name ??= "",
                                            style: CustomFont(
                                                    CustomColor.blackColor,
                                                    18,
                                                    FontWeight.w600)
                                                .font,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        SpacerWidth(w: 10),
                                        Text(
                                          mem.stage_name ??= "",
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  14,
                                                  FontWeight.w600)
                                              .font,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
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
          );
  }
}
