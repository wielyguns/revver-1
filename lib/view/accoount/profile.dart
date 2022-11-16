import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomHeader(
          title: "Profile",
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
                  title: "Full Name",
                  hint: "Your Full Name",
                  isValidator: true,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Username",
                  hint: "Your Username",
                  isValidator: true,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Member ID",
                  hint: "Your Member ID",
                  isValidator: true,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Sponsor ID",
                  hint: "Your Sponsor ID",
                  isValidator: true,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Phone",
                  hint: "Your Phone",
                  isValidator: true,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Email",
                  hint: "Your Email",
                  isValidator: true,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Secondary Email",
                  hint: "Your Secondary Email",
                  isValidator: true,
                ),
                SpacerHeight(h: 30),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: "Delete Account",
                        color: CustomColor.redColor,
                        func: () {},
                      ),
                    ),
                  ],
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
                GoRouter.of(context).pop();
              }
            },
          ),
        ),
      ),
    );
  }
}
