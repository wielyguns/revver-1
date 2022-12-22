// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/event.dart';

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
  String description;
  String long_description;
  String slug;
  String address;
  String image;

  getData(wid) async {
    await getEventDetail(wid).then((val) {
      setState(() {
        name = val['data']['name'];
        date = DateFormat("yyyy-MM-dd hh:mm:ss").parse(val['data']['date']);
        description = val['data']['description'];
        long_description = val['data']['long_description'];
        slug = val['data']['slug'];
        address = val['data']['address'];
        image = val['data']['image'];
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
        title: name ??= "",
        isPop: true,
        offMiddleLogo: true,
        image: image ??= "https://wallpaperaccess.com/full/733834.png",
        height: 300,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
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
