import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Privacy Policy",
        isPop: true,
      ),
      body: WebView(
        initialUrl: "https://info.revveracademy.com/privacy-policy",
      ),
    );
  }
}
