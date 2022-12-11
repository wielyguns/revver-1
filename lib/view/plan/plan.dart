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
  bool isLoad = true;
  getData() async {
    await getPlan().then((val) {
      setState(() {
        data = val['data'];
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
      appBar: CustomHeader(
        title: "Plan",
        isPop: true,
      ),
      body: (isLoad)
          ? Center(child: CircularProgressIndicator())
          : SfPdfViewer.asset(
              "assets/pdf/sample.pdf",
            ),
    );
  }
}
