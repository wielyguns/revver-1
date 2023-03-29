import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';
import 'package:revver/controller/plan.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Plan extends StatefulWidget {
  const Plan({Key key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  String data;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: ((context, orientation) {
      return Scaffold(
        appBar: (orientation == Orientation.portrait)
            ? CustomHeader(
                title: "Plan",
                isPop: true,
              )
            : null,
        body: SfPdfViewer.asset(
          (orientation == Orientation.portrait)
              ? "assets/pdf/plan.pdf"
              : "assets/pdf/plan.pdf",
          scrollDirection: PdfScrollDirection.horizontal,
          pageLayoutMode: PdfPageLayoutMode.single,
        ),
      );
    }));
  }
}
