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
        child: Text("Meeting"),
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
}
