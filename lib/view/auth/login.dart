import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/auth.dart';
import 'package:revver/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool password = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
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
                  SpacerHeight(h: 100),
                  Image.asset(
                    "assets/img/revver-white.png",
                    width: CustomScreen(context).width / 2,
                  ),
                  SpacerHeight(h: 20),
                  Text(
                    "Hello!",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                        color: CustomColor.whiteColor),
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
                            SpacerHeight(h: 35),
                            Text(
                              "Login",
                              style: CustomFont(CustomColor.brownColor, 36,
                                      FontWeight.w700)
                                  .font,
                            ),
                            SpacerHeight(h: 10),
                            Text(
                              "Already have an account? Please, login!",
                              style: CustomFont(CustomColor.oldGreyColor, 12,
                                      FontWeight.w400)
                                  .font,
                            ),
                            SpacerHeight(h: 20),
                            RegularForm(
                              icon: 'assets/svg/new-email.svg',
                              title: "Email",
                              hint: "Your Email",
                              isValidator: true,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                            ),
                            SpacerHeight(h: 20),
                            PasswordForm(
                              icon: 'assets/svg/new-password.svg',
                              title: "Password",
                              hint: "Your Password",
                              visible: password,
                              isValidator: true,
                              controller: passwordController,
                            ),
                            SpacerHeight(h: 40),
                            SizedBox(
                              width: CustomScreen(context).width - 40,
                              child: CustomButton(
                                title: "Login",
                                func: () async {
                                  if (!formKey.currentState.validate()) {
                                    customSnackBar(context, true,
                                        "Complete the form first!");
                                  } else {
                                    _onLoading();
                                    String email = emailController.text;
                                    String password = passwordController.text;
                                    await loginLoad(email, password).then(
                                      (val) async {
                                        Navigator.pop(context);
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        String token = val['api_key'];
                                        if (val['status'] == 200) {
                                          if (rememberMe) {
                                            await prefs.setString(
                                                'password', password);
                                            await prefs.setString(
                                                'email', email);
                                            await prefs.setString(
                                                'token', token);
                                          } else {
                                            await prefs.remove("password");
                                            await prefs.remove('email');
                                            await prefs.setString(
                                                'token', token);
                                          }
                                          await FirebaseMessaging.instance
                                              .subscribeToTopic("event");
                                          GoRouter.of(context)
                                              .go("/homepage/0");
                                        } else {
                                          customSnackBar(
                                              context, true, val['message']);
                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                            SpacerHeight(h: 20),
                            Row(
                              children: [
                                SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: Checkbox(
                                    value: rememberMe,
                                    activeColor: CustomColor.brownColor,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberMe = !rememberMe;
                                      });
                                    },
                                  ),
                                ),
                                SpacerWidth(w: 5),
                                Text(
                                  "Remember Me?",
                                  style: CustomFont(CustomColor.blackColor, 12,
                                          FontWeight.w400)
                                      .font,
                                ),
                              ],
                            ),
                            SpacerHeight(h: 20),
                            Row(
                              children: [
                                Text(
                                  "Don't have an account yet? ",
                                  style: CustomFont(CustomColor.blackColor, 12,
                                          FontWeight.w400)
                                      .font,
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Register here!",
                                    style: CustomFont(CustomColor.brownColor,
                                            12, FontWeight.w400)
                                        .font,
                                  ),
                                  onTap: () {
                                    GoRouter.of(context).go('/registration');
                                  },
                                ),
                              ],
                            ),
                            SpacerHeight(h: 40),
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
        //     title: "Login",
        //     func: () async {
        //       if (!formKey.currentState.validate()) {
        //         customSnackBar(context, true, "Complete the form first!");
        //       } else {
        //         String email = emailController.text;
        //         String password = passwordController.text;
        //         await loginLoad(email, password).then(
        //           (val) async {
        //             final prefs = await SharedPreferences.getInstance();
        //             String token = val['api_key'];
        //             if (val['status'] == 200) {
        //               if (rememberMe) {
        //                 await prefs.setString('password', password);
        //                 await prefs.setString('email', email);
        //                 await prefs.setString('token', token);
        //               } else {
        //                 await prefs.remove("password");
        //                 await prefs.remove('email');
        //                 await prefs.setString('token', token);
        //               }
        //               GoRouter.of(context).go("/homepage/0");
        //             } else {
        //               customSnackBar(context, true, val['message']);
        //             }
        //           },
        //         );
        //       }
        //     },
        //   ),
        // ),
      ),
    );
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          height: CustomScreen(context).height,
          width: CustomScreen(context).width,
          color: Colors.black.withOpacity(0.1),
          child: Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}
