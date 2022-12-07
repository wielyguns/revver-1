import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Plan extends StatefulWidget {
  const Plan({Key key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Plan",
        isPop: true,
      ),
      body: SfPdfViewer.asset(
        "assets/pdf/sample.pdf",
      ),
    );
  }
}
