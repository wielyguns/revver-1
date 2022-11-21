import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';

// ignore: must_be_immutable
class LeadsDetailForm extends StatefulWidget {
  LeadsDetailForm({Key key, this.x}) : super(key: key);
  String x;

  @override
  State<LeadsDetailForm> createState() => _LeadsDetailFormState();
}

class _LeadsDetailFormState extends State<LeadsDetailForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.x == null)
          ? CustomHeader(
              title: "Leads",
              isPop: true,
            )
          : PreferredSize(child: SizedBox(), preferredSize: Size(0, 0)),
      body: Center(
        child: Text("Detail"),
      ),
    );
  }
}
