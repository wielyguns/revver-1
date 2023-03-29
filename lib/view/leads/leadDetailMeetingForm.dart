// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/leads.dart';
import 'package:revver/controller/meeting.dart';
import 'package:revver/globals.dart';

class LeadsDetailMeetingForm extends StatefulWidget {
  LeadsDetailMeetingForm({Key key, this.id, this.lead_id}) : super(key: key);
  int id;
  int lead_id;

  @override
  State<LeadsDetailMeetingForm> createState() => _LeadsDetailMeetingFormState();
}

class _LeadsDetailMeetingFormState extends State<LeadsDetailMeetingForm> {
  bool isLoad = true;
  final formKey = GlobalKey<FormState>();
  DateTime dateNow = DateTime.now();

  String meeting_id;
  String lead_id;

  TextEditingController leadNameController = TextEditingController();
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
      });
      await getLeadDetail(lead_id).then((val) {
        setState(() {
          leadNameController.text = val['data']['name'];
          isLoad = false;
        });
      });
    });
  }

  getLeadId() async {
    await getLeadDetail(lead_id).then((val) {
      setState(() {
        leadNameController.text = val['data']['name'];
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    setState(() {
      lead_id = widget.lead_id.toString();
    });
    if (widget.id != 000) {
      getData(widget.id);
    } else {
      getLeadId();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: StandartHeader(
          title: (widget.id != 000) ? "Edit Meeting" : "Create Meeting",
          isPop: true,
        ),
        body: (isLoad)
            ? Center(child: CupertinoActivityIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Center(
                      //   child: Text(
                      //     ((widget.id == 000) ? "isForms" : "isUser"),
                      //   ),
                      // ),
                      SpacerHeight(h: 20),
                      RegularForm(
                        title: "Event Name",
                        hint: "eg: Meeting with new project",
                        controller: eventNameController,
                        isValidator: true,
                      ),
                      SpacerHeight(h: 20),
                      RegularForm(
                        icon: 'assets/svg/new-user.svg',
                        title: "Related to Lead",
                        hint: "",
                        controller: leadNameController,
                        readOnly: true,
                        isValidator: false,
                      ),
                      SpacerHeight(h: 20),
                      DateTimePickerForm(
                        icon: 'assets/svg/new-calendar-month.svg',
                        title: "Event Date",
                        hint: "t",
                        date: dateNow,
                        callback: (x) {
                          setState(() => dateNow = x);
                        },
                      ),
                      SpacerHeight(h: 20),
                      MultiLineForm(
                        title: "Event Description",
                        hint: "eg: Presentation to the new prospect",
                        controller: eventDescriptionController,
                        isValidator: false,
                      ),
                      SpacerHeight(h: 20),
                      RegularForm(
                        icon: 'assets/svg/new-location.svg',
                        title: "Event Location",
                        hint: "eg: Coffee Shop Tunjungan Plaza",
                        controller: eventLocationController,
                        isValidator: false,
                      ),
                      SpacerHeight(h: 20),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: Container(
          color: CustomColor.backgroundColor,
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
                          lead_id,
                          eventNameController.text,
                          DateFormat("yyyy-MM-dd HH:mm:ss").format(dateNow),
                          eventDescriptionController.text,
                          eventLocationController.text,
                          "1")
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
                    lead_id,
                    eventNameController.text,
                    DateFormat("yyyy-MM-dd HH:mm:ss").format(dateNow),
                    eventDescriptionController.text,
                    eventLocationController.text,
                    "1",
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
