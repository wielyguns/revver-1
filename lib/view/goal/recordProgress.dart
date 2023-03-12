// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/goal.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/goal.dart';

class RecordProgress extends StatefulWidget {
  RecordProgress({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<RecordProgress> createState() => _RecordProgressState();
}

class _RecordProgressState extends State<RecordProgress> {
  final formKey = GlobalKey<FormState>();
  TextEditingController kananController = TextEditingController();
  TextEditingController kiriController = TextEditingController();
  TextEditingController sponsorController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomHeader(
          title: "Record Progress",
          isPop: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SpacerHeight(h: 20),
                RegularForm(
                  icon: 'assets/svg/new-counter.svg',
                  title: "Total Kanan",
                  hint: "eg: 1",
                  controller: kananController,
                  isValidator: false,
                  keyboardType: TextInputType.number,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  icon: 'assets/svg/new-counter.svg',
                  title: "Total Kiri",
                  hint: "eg: 1",
                  controller: kiriController,
                  isValidator: false,
                  keyboardType: TextInputType.number,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  icon: 'assets/svg/new-counter.svg',
                  title: "Total Sponsor",
                  hint: "eg: 1",
                  controller: sponsorController,
                  isValidator: false,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: CustomColor.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: CustomButton(
            title: "Record Progress",
            func: () async {
              if (!formKey.currentState.validate()) {
                customSnackBar(context, true, "Complete the form first!");
              } else {
                await postRecordProgress(
                        kananController.text,
                        kiriController.text,
                        sponsorController.text,
                        widget.id.toString())
                    .then((val) {
                  if (val['status'] == 200) {
                    customSnackBar(context, false, val['status'].toString());
                    GoRouter.of(context).pop();
                  } else {
                    customSnackBar(context, true, val['status'].toString());
                  }
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
