import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RefundPolicy extends StatefulWidget {
  const RefundPolicy({Key key}) : super(key: key);

  @override
  State<RefundPolicy> createState() => _RefundPolicyState();
}

class _RefundPolicyState extends State<RefundPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Refund Policy",
        isPop: true,
      ),
      body: WebView(
        initialUrl: "https://info.revveracademy.com/refund-policy",
      ),
    );
  }
}
