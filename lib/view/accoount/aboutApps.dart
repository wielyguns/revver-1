import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';

class AboutApps extends StatefulWidget {
  const AboutApps({Key key}) : super(key: key);

  @override
  State<AboutApps> createState() => _AboutAppsState();
}

class _AboutAppsState extends State<AboutApps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "About Apps",
        isPop: true,
      ),
    );
  }
}
