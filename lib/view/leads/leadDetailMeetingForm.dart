import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';

class LeadsDetailMeetingForm extends StatefulWidget {
  const LeadsDetailMeetingForm({Key key}) : super(key: key);

  @override
  State<LeadsDetailMeetingForm> createState() => _LeadsDetailMeetingFormState();
}

class _LeadsDetailMeetingFormState extends State<LeadsDetailMeetingForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Meeting Form",
        isPop: true,
      ),
    );
  }
}
