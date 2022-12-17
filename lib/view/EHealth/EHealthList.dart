// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';

class EHealthList extends StatefulWidget {
  EHealthList({Key key, this.name, this.height, this.weight, this.age})
      : super(key: key);
  String name;
  String height;
  String weight;
  String age;

  @override
  State<EHealthList> createState() => _EHealthListState();
}

class _EHealthListState extends State<EHealthList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "E-Health",
        isPop: true,
      ),
      body: SizedBox(),
    );
  }
}
