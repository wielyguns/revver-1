import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';

class EHealthDetail extends StatefulWidget {
  EHealthDetail({Key key, this.name, this.height, this.weight, this.age})
      : super(key: key);
  String name;
  String height;
  String weight;
  String age;

  @override
  State<EHealthDetail> createState() => _EHealthDetailState();
}

class _EHealthDetailState extends State<EHealthDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandartHeader(
        title: "E-Health",
        isPop: true,
      ),
      body: SizedBox(),
    );
  }
}
