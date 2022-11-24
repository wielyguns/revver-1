import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/registration.dart';
import 'package:revver/globals.dart';

class Registration extends StatefulWidget {
  Registration({Key key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController memberIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sponsorIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool password = false;

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
                    "Registration",
                    style: CustomFont.heading36,
                  ),
                  SpacerHeight(h: 10),
                  Text(
                    "Don't have an account yet? Register here!",
                    style: CustomFont.subheading,
                  ),
                  SpacerHeight(h: 20),
                  RegularForm(
                    title: "Full Name",
                    hint: "Your Full Name",
                    isValidator: true,
                    controller: nameController,
                  ),
                  SpacerHeight(h: 20),
                  RegularForm(
                    title: "Username",
                    hint: "Your Username",
                    isValidator: true,
                    controller: usernameController,
                  ),
                  SpacerHeight(h: 20),
                  RegularForm(
                    title: "Email",
                    hint: "Your Email",
                    isValidator: true,
                    controller: emailController,
                  ),
                  SpacerHeight(h: 20),
                  RegularForm(
                    title: "Phone",
                    hint: "Your Phone",
                    isValidator: true,
                    controller: phoneController,
                  ),
                  SpacerHeight(h: 20),
                  RegularForm(
                    title: "Sponsor ID",
                    hint: "Your Sponsor ID",
                    isValidator: false,
                    controller: sponsorIdController,
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
                  PasswordForm(
                    title: "Confirm Password",
                    hint: "Your Confirm Password",
                    visible: password,
                    isValidator: true,
                    controller: confirmPasswordController,
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
                          "Login here!",
                          style: CustomFont.link,
                        ),
                        onTap: () {
                          GoRouter.of(context).go('/login');
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
              title: "Registration",
              func: () async {
                if (!formKey.currentState.validate()) {
                  customSnackBar(context, true, "Complete the form first!");
                } else {
                  String name = nameController.text;
                  String username = usernameController.text;
                  String memberId = "000001";
                  String email = emailController.text;
                  String phone = phoneController.text;
                  String sponsorId = sponsorIdController.text;
                  String password = passwordController.text;
                  String confirmPassword = confirmPasswordController.text;
                  await registrationPost(name, username, memberId, email, phone,
                          sponsorId, password, confirmPassword)
                      .then(
                    (val) async {
                      print(val['data'].toString());
                      customSnackBar(context, true, val['data'].toString());
                      // GoRouter.of(context).go("/homepage/0");
                    },
                  );
                }
              },
            )),
      ),
    );
  }
}
