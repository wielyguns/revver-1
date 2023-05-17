// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/event.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class GlobalEvent extends StatefulWidget {
  GlobalEvent({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<GlobalEvent> createState() => _GlobalEventState();
}

class _GlobalEventState extends State<GlobalEvent> {
  bool isLoad = true;
  String name;
  DateTime date;
  String time;
  String description;
  String long_description;
  String slug;
  String address;
  String image;

  getData(wid) async {
    await getEventDetail(wid).then((val) {
      setState(() {
        name = val['data']['name'];
        date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(val['data']['date']);
        description = val['data']['description'];
        long_description = val['data']['long_description'];
        slug = val['data']['slug'];
        address = val['data']['address'];
        image = val['data']['image'];
        time = DateFormat.jm().format(date);
        isLoad = false;
      });
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
      appBar: CustomHeader(
        title: "",
        isPop: true,
        offMiddleLogo: true,
        image: image ??= "https://wallpaperaccess.com/full/733834.png",
        height: 300,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpacerHeight(h: 20),
                  Text(
                    name,
                    style:
                        CustomFont(CustomColor.brownColor, 20, FontWeight.w700)
                            .font,
                  ),
                  SpacerHeight(h: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 24,
                        color: CustomColor.brownColor,
                      ),
                      SpacerWidth(w: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tanggal(date),
                            style: CustomFont(
                                    CustomColor.blackColor, 14, FontWeight.w600)
                                .font,
                          ),
                          Text(
                            time,
                            style: CustomFont(CustomColor.oldGreyColor, 11,
                                    FontWeight.w400)
                                .font,
                          ),
                        ],
                      )
                    ],
                  ),
                  SpacerHeight(h: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 24,
                        color: CustomColor.brownColor,
                      ),
                      SpacerWidth(w: 10),
                      Text(
                        address,
                        style: CustomFont(
                                CustomColor.blackColor, 14, FontWeight.w600)
                            .font,
                      ),
                    ],
                  ),
                  SpacerHeight(h: 20),
                  (description != null)
                      ? Html(data: description ??= "")
                      : SizedBox(),
                  (description != null) ? SpacerHeight(h: 20) : SizedBox(),
                  Html(data: long_description ??= "")
                ],
              ),
            ),
    );
  }
}
