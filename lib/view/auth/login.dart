import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/login.dart';
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
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpacerHeight(h: 20),
                  Text(
                    "Login",
                    style: CustomFont.heading36,
                  ),
                  SpacerHeight(h: 10),
                  Text(
                    "Already have an account? Please, login!",
                    style: CustomFont.subheading,
                  ),
                  SpacerHeight(h: 20),
                  RegularForm(
                    title: "Email",
                    hint: "Your Email",
                    isValidator: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  SpacerHeight(h: 20),
                  PasswordForm(
                    title: "Password",
                    hint: "Your Password",
                    visible: password,
                    isValidator: true,
                    controller: passwordController,
                  ),
                  SpacerHeight(h: 20),
                  Row(
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Checkbox(
                          value: rememberMe,
                          activeColor: CustomColor.goldColor,
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
                        style: CustomFont.regular12,
                      ),
                    ],
                  ),
                  SpacerHeight(h: 20),
                  Row(
                    children: [
                      Text(
                        "Don't have an account yet? ",
                        style: CustomFont.regular12,
                      ),
                      GestureDetector(
                        child: Text(
                          "Register here!",
                          style: CustomFont.link,
                        ),
                        onTap: () {
                          GoRouter.of(context).go('/registration');
                        },
                      ),
                    ],
                  ),
                  SpacerHeight(h: 20),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: CustomColor.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomButton(
            title: "Login",
            func: () async {
              if (!formKey.currentState.validate()) {
                customSnackBar(context, true, "Complete the form first!");
              } else {
                String email = emailController.text;
                String password = passwordController.text;
                await loginLoad(email, password).then(
                  (val) async {
                    final prefs = await SharedPreferences.getInstance();
                    String token = val['api_key'];
                    if (val['status'] == 200) {
                      if (rememberMe) {
                        await prefs.setString('password', password);
                        await prefs.setString('email', email);
                        await prefs.setString('token', token);
                      } else {
                        await prefs.remove("password");
                        await prefs.remove('email');
                        await prefs.setString('token', token);
                      }
                      GoRouter.of(context).go("/homepage/0");
                    } else {
                      customSnackBar(context, true, val['message']);
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
