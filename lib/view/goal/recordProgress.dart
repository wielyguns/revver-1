import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/header.dart';

class RecordProgress extends StatefulWidget {
  const RecordProgress({Key key}) : super(key: key);

  @override
  State<RecordProgress> createState() => _RecordProgressState();
}

class _RecordProgressState extends State<RecordProgress> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
          appBar: CustomHeader(
        title: "Record Progress",
        isPop: true,
      )),
    );
  }
}
