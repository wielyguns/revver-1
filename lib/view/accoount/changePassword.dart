import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/account.dart';
import 'package:revver/globals.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: CupertinoNavigationBarBackButton(
              color: CustomColor.whiteColor,
              onPressed: () => GoRouter.of(context).pop()),
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              height: CustomScreen(context).height,
              width: CustomScreen(context).width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/revver-bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SpacerHeight(h: 200),
                  Image.asset(
                    "assets/img/revver-white.png",
                    width: CustomScreen(context).width / 2,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: CustomScreen(context).height,
                width: CustomScreen(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                    )),
                    Container(
                      width: CustomScreen(context).width,
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      decoration: BoxDecoration(
                        color: CustomColor.whiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SpacerHeight(h: 40),
                            Text(
                              "Change Password",
                              style: CustomFont(CustomColor.brownColor, 32,
                                      FontWeight.w700)
                                  .font,
                            ),
                            SpacerHeight(h: 40),
                            PasswordForm(
                              icon: 'assets/svg/new-password.svg',
                              title: "New Password",
                              hint: "Your New Password",
                              visible: false,
                              isValidator: true,
                              controller: passwordController,
                            ),
                            SpacerHeight(h: 20),
                            PasswordForm(
                              icon: 'assets/svg/new-password.svg',
                              title: "Confirm New Password",
                              hint: "Your New Password",
                              visible: false,
                              isValidator: true,
                              controller: confirmPasswordController,
                            ),
                            SpacerHeight(h: 80),
                            SizedBox(
                              width: CustomScreen(context).width - 40,
                              child: CustomButton(
                                title: "Save",
                                func: () async {
                                  if (!formKey.currentState.validate()) {
                                    customSnackBar(context, true,
                                        "Complete the form first!");
                                  } else {
                                    if (passwordController.text !=
                                        confirmPasswordController.text) {
                                      customSnackBar(
                                          context, true, "Password not match!");
                                    } else {
                                      await patchAccountChangePassword(
                                              passwordController.text)
                                          .then((val) {
                                        if (val['status'] == 200) {
                                          GoRouter.of(context).pop();
                                        } else {
                                          customSnackBar(context, true,
                                              val['data'].toString());
                                        }
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                            SpacerHeight(h: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: Container(
        //   color: CustomColor.whiteColor,
        //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        //   child: CustomButton(
        //     title: "Save",
        //     func: () async {
        //       if (!formKey.currentState.validate()) {
        //         customSnackBar(context, true, "Complete the form first!");
        //       } else {
        //         if (passwordController.text != confirmPasswordController.text) {
        //           customSnackBar(context, true, "Password not match!");
        //         } else {
        //           await patchAccountChangePassword(passwordController.text)
        //               .then((val) {
        //             if (val['status'] == 200) {
        //               GoRouter.of(context).pop();
        //             } else {
        //               customSnackBar(context, true, val['data'].toString());
        //             }
        //           });
        //         }
        //       }
        //     },
        //   ),
        // ),
      ),
    );
  }
}

        // body: SingleChildScrollView(
        //   padding: EdgeInsets.symmetric(horizontal: 35),
        //   child: Form(
        //     key: formKey,
        //     child: Column(
        //       children: [
        //         SpacerHeight(h: 20),
        //         PasswordForm(
        //           title: "New Password",
        //           hint: "Your New Password",
        //           visible: false,
        //           isValidator: true,
        //           controller: passwordController,
        //         ),
        //         SpacerHeight(h: 20),
        //         PasswordForm(
        //           title: "Confirm New Password",
        //           hint: "Your New Password",
        //           visible: false,
        //           isValidator: true,
        //           controller: confirmPasswordController,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),