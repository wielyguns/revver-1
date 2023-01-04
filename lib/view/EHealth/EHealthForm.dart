import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class EHealthForm extends StatefulWidget {
  const EHealthForm({Key key}) : super(key: key);

  @override
  State<EHealthForm> createState() => _EHealthFormState();
}

class _EHealthFormState extends State<EHealthForm> {
  bool isLoad = true;
  List<String> gender = ['Male', 'Female'];
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String selectedGender;
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomHeader(
          title: "E-Health",
          isPop: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Name",
                  hint: "Enter your name",
                  controller: nameController,
                  isValidator: true,
                ),
                SpacerHeight(h: 20),
                StringDropdown(
                  title: "Gender",
                  hint: "Male / Female",
                  list: gender,
                  value: selectedGender,
                  callback: (val) {
                    selectedGender = val;
                  },
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Height",
                  hint: "eg: 160",
                  isValidator: false,
                  controller: heightController,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                    title: "Weight",
                    hint: "eg: 60",
                    isValidator: false,
                    controller: weightController),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Age",
                  hint: "eg: 20",
                  isValidator: false,
                  controller: ageController,
                ),
                SpacerHeight(h: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: CustomColor.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomButton(
            title: "Save",
            func: () async {
              if (!formKey.currentState.validate()) {
                customSnackBar(context, true, "Complete the form first!");
              } else {
                String name = nameController.text ??= "0";
                String height =
                    (heightController.text != "") ? heightController.text : "0";
                String weight =
                    (weightController.text != "") ? weightController.text : "0";
                String gender = (selectedGender != null) ? selectedGender : "0";
                String age =
                    (ageController.text != "") ? ageController.text : "0";
                GoRouter.of(context)
                    .push("/e-health-list/$name/$height/$weight/$gender/$age");
              }
            },
          ),
        ),
      ),
    );
  }
}
