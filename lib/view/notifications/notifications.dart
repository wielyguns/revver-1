import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Notifications",
                    style:
                        CustomFont(CustomColor.whiteColor, 32, FontWeight.w600)
                            .font,
                  ),
                ],
              ),
              SpacerHeight(h: 40),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: CustomColor.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(65),
                      topRight: Radius.circular(65),
                    ),
                  ),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 20,
                    itemBuilder: ((context, index) {
                      // Member mem = member[index];
                      // String id = mem.id.toString();
                      return Column(
                        children: [
                          InkWell(
                            // onTap: () => GoRouter.of(context)
                            //     .push('/downline-detail/$id'),
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
                                      color: CustomColor.greyColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.notifications,
                                      color: CustomColor.whiteColor,
                                    ),
                                  ),
                                  SpacerWidth(w: 10),
                                  Expanded(
                                    child: Text(
                                      "mem.name",
                                      style: CustomFont(CustomColor.blackColor,
                                              18, FontWeight.w600)
                                          .font,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SpacerWidth(w: 10),
                                  Text(
                                    "mem.stage_name",
                                    style: CustomFont(CustomColor.oldGreyColor,
                                            14, FontWeight.w600)
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
