import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Change Password",
        isPop: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SpacerHeight(h: 20),
            PasswordForm(
              title: "Old Password",
              hint: "Your Old Password",
              visible: false,
              isValidator: true,
            ),
            SpacerHeight(h: 20),
            PasswordForm(
              title: "New Password",
              hint: "Your New Password",
              visible: false,
              isValidator: true,
            ),
            SpacerHeight(h: 20),
            PasswordForm(
              title: "Confirm New Password",
              hint: "Your New Password",
              visible: false,
              isValidator: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: CustomColor.whiteColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CustomButton(
          title: "Save",
          func: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
    );
  }
}
