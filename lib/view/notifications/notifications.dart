import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/event.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/event.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isLoad = true;
  List<Event> event = [];

  getData() async {
    await getEvent().then((val) {
      if (!mounted) return;
      setState(() {
        event = val;
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
                image: AssetImage('assets/img/revver-bg.jpg'),
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
                  padding: EdgeInsets.only(top: 55, left: 35, right: 35),
                  decoration: BoxDecoration(
                    color: CustomColor.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(65),
                      topRight: Radius.circular(65),
                    ),
                  ),
                  child: (isLoad)
                      ? Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: event.length,
                          itemBuilder: ((context, index) {
                            Event ev = event[index];
                            String id = ev.id.toString();
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () => GoRouter.of(context)
                                      .push("/global-event/$id"),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            Icons.notifications,
                                            color: CustomColor.whiteColor,
                                          ),
                                        ),
                                        SpacerWidth(w: 10),
                                        Expanded(
                                          child: Text(
                                            ev.name,
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
                                          ev.date,
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
