// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';
import 'package:revver/view/leads/leadsDetailForm.dart';
import 'package:revver/view/leads/leadsDetailMeeting.dart';

class LeadsDetail extends StatefulWidget {
  LeadsDetail({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<LeadsDetail> createState() => _LeadsDetailState();
}

class _LeadsDetailState extends State<LeadsDetail> {
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children = [
      LeadsDetailForm(x: "x", id: widget.id),
      LeadsDetailMeeting(id: widget.id),
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
                              text: "Detail",
                            ),
                            Tab(
                              text: "Meeting",
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

// return DefaultTabController(
//   initialIndex: 0,
//   length: 2,
//   child: Scaffold(
//     appBar: AppBar(
//       backgroundColor: CustomColor.whiteColor,
//       elevation: 0,
//       title: Text("Leads Detail", style: CustomFont.tabbarHeading),
//       leading: CupertinoNavigationBarBackButton(
//           color: CustomColor.blackColor,
//           onPressed: () => GoRouter.of(context).pop()),
//       bottom: PreferredSize(
//         preferredSize: Size(0, 50),
//         child: Container(
//           color: CustomColor.brownColor,
//           child: TabBar(
//             indicatorColor: CustomColor.blackColor,
//             indicatorWeight: 3,
//             tabs: [
//               Tab(
//                 text: "Detail",
//               ),
//               Tab(
//                 text: "Meeting",
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//     body: TabBarView(
//       physics: NeverScrollableScrollPhysics(),
//       children: _children,
//     ),
//   ),
// );