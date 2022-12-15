// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/EHealth.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/meeting.dart';

class LeadsDetailMeeting extends StatefulWidget {
  LeadsDetailMeeting({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<LeadsDetailMeeting> createState() => _LeadsDetailMeetingState();
}

class _LeadsDetailMeetingState extends State<LeadsDetailMeeting> {
  bool isLoad = true;
  List<Meeting> meeting = [];

  getData() async {
    await getMeeting().then((val) {
      setState(() {
        List<Meeting> x = val.where((e) => e.lead_id == widget.id).toList();
        meeting = x;
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: (isLoad)
            ? Center(child: CircularProgressIndicator())
            : (meeting.isEmpty)
                ? Center(child: Text("Not Found!"))
                : listWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String x = "000";
          GoRouter.of(context).push("/leads-detail-meeting-form/$x");
        },
        backgroundColor: CustomColor.brownColor,
        child: Icon(Icons.add),
      ),
    );
  }

  listWidget() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: meeting.length,
      itemBuilder: (context, index) {
        Meeting meet = meeting[index];
        return Column(
          children: [
            (index == 0) ? SpacerHeight(h: 20) : SizedBox(),
            listItem(meet.id, meet.name, meet.date),
            SpacerHeight(h: 20),
          ],
        );
      },
    );
  }

  listItem(id, name, date) {
    return InkWell(
      onTap: (() =>
          GoRouter.of(context).push("/leads-detail-meeting-form/$id")),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: CustomColor.brownColor,
                borderRadius: BorderRadius.circular(5)),
            child: SvgPicture.asset(
              "assets/svg/bell-solid.svg",
              color: CustomColor.whiteColor,
            ),
          ),
          SpacerWidth(w: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style:
                        CustomFont(CustomColor.blackColor, 16, FontWeight.bold)
                            .font,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  // width: 100,
                  child: Text(
                    tanggal(DateTime.parse(date), shortMonth: true),
                    style: CustomFont(
                            CustomColor.oldGreyColor, 12, FontWeight.bold)
                        .font,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
