import 'dart:io';

import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Report extends StatefulWidget {
  const Report({Key key}) : super(key: key);
  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomHeader(
          title: "Report",
          isPop: true,
        ),
        body: WebView(
          initialUrl: "https://google.com",
        ));
  }
}
