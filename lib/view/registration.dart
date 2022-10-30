import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final formKey = GlobalKey<FormState>();
  bool password = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SpacerHeight(h: 20),
                  Text(
                    "Login",
                    style: CustomFont.heading36,
                  ),
                  const SpacerHeight(h: 10),
                  Text(
                    "Already have an account? Please, login!",
                    style: CustomFont.subheading,
                  ),
                  const SpacerHeight(h: 20),
                  RegularForm(
                    title: "Email",
                    hint: "Your Email",
                    isValidator: true,
                  ),
                  const SpacerHeight(h: 20),
                  PasswordForm(
                    title: "Password",
                    hint: "Your Password",
                    visible: password,
                    isValidator: false,
                  ),
                  const SpacerHeight(h: 20),
                  const SpacerHeight(h: 20),
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
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
            color: CustomColor.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomButton(
              title: "Login",
              func: () {
                if (formKey.currentState.validate()) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data')),
                  // );
                  customSnackBar(context, false, "Login");
                }
              },
            )),
      ),
    );
  }
}
