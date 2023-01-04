import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';
import 'package:revver/view/support/myDownline.dart';
import 'package:revver/view/support/myProgress.dart';

class Support extends StatefulWidget {
  const Support({Key key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children = [
      MyProgress(),
      MyDownline(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: CupertinoNavigationBarBackButton(
              color: CustomColor.whiteColor,
              onPressed: () => GoRouter.of(context).pop()),
        ),
        body: Stack(
          children: [
            Container(
              height: CustomScreen(context).height,
              width: CustomScreen(context).width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/background-resize.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                SpacerHeight(h: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Support",
                      style: CustomFont(
                              CustomColor.whiteColor, 32, FontWeight.w600)
                          .font,
                    ),
                  ],
                ),
                SpacerHeight(h: 40),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColor.backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(65),
                        topRight: Radius.circular(65),
                      ),
                    ),
                    child: Column(
                      children: [
                        TabBar(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          indicatorColor: CustomColor.brownColor,
                          labelColor: CustomColor.blackColor,
                          labelStyle: CustomFont(
                                  CustomColor.blackColor, 16, FontWeight.w600)
                              .font,
                          indicatorWeight: 3,
                          tabs: [
                            Tab(
                              text: "My Progress",
                            ),
                            Tab(
                              text: "My Downline",
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: _children,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// TabBarView(
//   physics: NeverScrollableScrollPhysics(),
//   children: _children,
// ),

// TabBar(
//   indicatorColor: CustomColor.blackColor,
//   indicatorWeight: 3,
//   tabs: [
//     Tab(
//       text: "My Progress",
//     ),
//     Tab(
//       text: "My Downline",
//     ),
//   ],
// ),
