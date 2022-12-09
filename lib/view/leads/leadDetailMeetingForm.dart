import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';

class LeadsDetailMeetingForm extends StatefulWidget {
  LeadsDetailMeetingForm({Key key, this.id}) : super(key: key);
  int id;

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
      body: Center(
        child: Text(
          ((widget.id == 000) ? "isForms" : "isUser"),
        ),
      ),
    );
  }
}
