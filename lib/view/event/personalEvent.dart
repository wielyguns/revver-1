// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/meeting.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class PersonalEvent extends StatefulWidget {
  PersonalEvent({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<PersonalEvent> createState() => _PersonalEventState();
}

class _PersonalEventState extends State<PersonalEvent> {
  bool isLoad = true;
  final formKey = GlobalKey<FormState>();
  DateTime dateNow = DateTime.now();

  String meeting_id;

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();

  getData(id) async {
    await getMeetingDetail(id).then((val) async {
      setState(() {
        meeting_id = val['data']['id'].toString();
        eventNameController.text = val['data']['name'];
        dateNow = DateFormat("yyyy-MM-dd HH:mm:ss").parse(val['data']['date']);
        eventDescriptionController.text = val['data']['description'];
        eventLocationController.text = val['data']['location'];
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    if (widget.id != 000) {
      getData(widget.id);
    } else {
      setState(() {
        isLoad = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomHeader(
          isPop: true,
          title: (widget.id == 000) ? "Buat Event" : "Edit Event",
        ),
        body: (isLoad)
            ? Center(child: CupertinoActivityIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SpacerHeight(h: 20),
                      Form(
                          key: formKey,
                          child: Column(
                            children: [
                              RegularForm(
                                title: "Nama Event",
                                hint: "eg: Meeting proyek baru",
                                controller: eventNameController,
                                isValidator: true,
                              ),
                              SpacerHeight(h: 20),
                              DateTimePickerForm(
                                icon: 'assets/svg/new-calendar-month.svg',
                                title: "Tanggal Event",
                                hint: "t",
                                date: dateNow,
                                callback: (x) {
                                  setState(() => dateNow = x);
                                },
                              ),
                              SpacerHeight(h: 20),
                              MultiLineForm(
                                title: "Description Event",
                                hint: "eg: Persentasi proyek baru",
                                controller: eventDescriptionController,
                                isValidator: false,
                              ),
                              SpacerHeight(h: 20),
                              RegularForm(
                                icon: 'assets/svg/new-location.svg',
                                title: "Lokasi Event",
                                hint: "eg: Coffee Shop Tunjungan Plaza",
                                controller: eventLocationController,
                                isValidator: false,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: Container(
          color: CustomColor.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: CustomButton(
            title: "Save",
            func: () async {
              if (!formKey.currentState.validate()) {
                customSnackBar(context, true, "Complete the form first!");
              } else {
                if (widget.id != 000) {
                  //patch
                  await patchMeeting(
                          meeting_id,
                          "1",
                          eventNameController.text,
                          DateFormat("yyyy-MM-dd HH:mm:ss").format(dateNow),
                          eventDescriptionController.text,
                          eventLocationController.text,
                          "0")
                      .then((val) {
                    if (val['status'] == 200) {
                      customSnackBar(context, false, "Sukses");
                      GoRouter.of(context).pop();
                    } else {
                      customSnackBar(context, true, "Gagal");
                    }
                  });
                } else {
                  //add
                  await postMeeting(
                    "1",
                    eventNameController.text,
                    DateFormat("yyyy-MM-dd HH:mm:ss").format(dateNow),
                    eventDescriptionController.text,
                    eventLocationController.text,
                    "0",
                  ).then((val) {
                    if (val['status'] == 200) {
                      customSnackBar(context, false, "Sukses");
                      GoRouter.of(context).pop();
                    } else {
                      customSnackBar(context, true, "Gagal");
                    }
                  });
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
