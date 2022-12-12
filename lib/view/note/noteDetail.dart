// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';

class NoteDetail extends StatefulWidget {
  NoteDetail({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  bool isLoad = true;
  bool isContains = false;

  @override
  void initState() {
    if (widget.id != 000) {
      setState(() {
        isContains = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "title",
        isPop: true,
      ),
    );
  }
}
