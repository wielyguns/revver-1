import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class PersonalEvent extends StatefulWidget {
  PersonalEvent({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<PersonalEvent> createState() => _PersonalEventState();
}

class _PersonalEventState extends State<PersonalEvent> {
  DateTime date = DateTime.now();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    int id = widget.id;
    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomHeader(
          isPop: true,
          title: (id == 0) ? "Create Event" : "Edit Event",
          svgName: (id == 0) ? "" : "trash-can-solid.svg",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SpacerHeight(h: 20),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        RegularForm(
                          title: "Event Name",
                          hint: "eg: Meeting with new project",
                          isValidator: true,
                        ),
                        SpacerHeight(h: 20),
                        DateTimePickerForm(
                          title: "Date",
                          hint: "t",
                          date: date,
                          callback: (x) {
                            setState(() => date = x);
                          },
                        ),
                        SpacerHeight(h: 20),
                        MultiLineForm(
                          title: "Event Description",
                          hint: "eg: Presentation to the new prospect",
                          isValidator: true,
                        ),
                        SpacerHeight(h: 20),
                        MultiLineForm(
                          title: "Event Location",
                          hint: "eg: Coffee Shop Tunjungan Plaza",
                          isValidator: true,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: CustomColor.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomButton(
            title: "Save",
            func: () {
              if (!formKey.currentState.validate()) {
                customSnackBar(context, true, "Complete the form first!");
              } else {
                // GoRouter.of(context).pop();
                print(date);
              }
            },
          ),
        ),
      ),
    );
  }
}
