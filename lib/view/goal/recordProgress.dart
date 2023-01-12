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
  const RecordProgress({Key key}) : super(key: key);

  @override
  State<RecordProgress> createState() => _RecordProgressState();
}

class _RecordProgressState extends State<RecordProgress> {
  bool isLoad = true;
  final formKey = GlobalKey<FormState>();
  List<ReferralRate> rrate = [];
  ReferralRate selectedReferral;
  TextEditingController qtyController = TextEditingController();

  getData() async {
    await getReferralRate().then((val) async {
      setState(() {
        rrate = val;
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    getData();
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
        body: (isLoad)
            ? Center(child: CupertinoActivityIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SpacerHeight(h: 20),
                      RegularForm(
                        title: "Total Package",
                        hint: "eg: 1",
                        controller: qtyController,
                        isValidator: true,
                        keyboardType: TextInputType.number,
                      ),
                      SpacerHeight(h: 20),
                      referralWidget(
                        "Package",
                        "Choose Package",
                        rrate,
                        selectedReferral,
                        true,
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
                        selectedReferral.id.toString(), qtyController.text)
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

  Widget referralWidget(
    String title,
    String hint,
    List<ReferralRate> list,
    ReferralRate selectedItem,
    bool isValidator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomFont.regular12),
        SizedBox(height: 10),
        DropdownButtonFormField(
          validator: (value) {
            if (isValidator) {
              if (value == null) {
                return 'Please enter your $title';
              }
              return null;
            } else {
              return null;
            }
          },
          value: selectedItem,
          items: list.map((v) {
            return DropdownMenuItem(
              value: v,
              child: Text(
                v.name,
                style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400)
                    .font,
              ),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              selectedReferral = val;
            });
          },
          dropdownColor: CustomColor.whiteColor,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
        ),
      ],
    );
  }
}
