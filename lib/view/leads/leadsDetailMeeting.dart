import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/globals.dart';

class LeadsDetailMeeting extends StatefulWidget {
  const LeadsDetailMeeting({Key key}) : super(key: key);

  @override
  State<LeadsDetailMeeting> createState() => _LeadsDetailMeetingState();
}

class _LeadsDetailMeetingState extends State<LeadsDetailMeeting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: listWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push("/leads-detail-meeting-form");
        },
        backgroundColor: CustomColor.goldColor,
        child: Icon(Icons.add),
      ),
    );
  }

  listWidget() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return listItem();
      },
    );
  }

  listItem() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            color: Colors.red,
          ),
          Text("data"),
        ],
      ),
    );
  }
}
