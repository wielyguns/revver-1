import 'package:flutter/material.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class Leads extends StatefulWidget {
  Leads({Key key}) : super(key: key);

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SpacerHeight(h: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text("Leads", style: CustomFont.heading24),
            ),
          ],
        ),
      ),
    );
  }
}
