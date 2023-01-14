import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/auth.dart';
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
              child: Column(
                children: [
                  SpacerHeight(h: 250),
                  Container(
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
                            "Registration",
                            style: CustomFont(
                                    CustomColor.brownColor, 36, FontWeight.w700)
                                .font,
                          ),
                          SpacerHeight(h: 10),
                          Text(
                            "Don't have an account yet? Register here!",
                            style: CustomFont(CustomColor.oldGreyColor, 12,
                                    FontWeight.w400)
                                .font,
                          ),
                          SpacerHeight(h: 20),
                          RegularForm(
                            icon: 'assets/svg/new-user.svg',
                            title: "Full Name",
                            hint: "Your Full Name",
                            isValidator: true,
                            controller: nameController,
                          ),
                          SpacerHeight(h: 20),
                          RegularForm(
                            icon: 'assets/svg/new-user.svg',
                            title: "Username",
                            hint: "Your Username",
                            isValidator: true,
                            controller: usernameController,
                          ),
                          SpacerHeight(h: 20),
                          RegularForm(
                            icon: 'assets/svg/new-email.svg',
                            title: "Email",
                            hint: "Your Email",
                            isValidator: true,
                            controller: emailController,
                          ),
                          SpacerHeight(h: 20),
                          RegularForm(
                            icon: 'assets/svg/new-phone.svg',
                            title: "Phone",
                            hint: "Your Phone",
                            isValidator: true,
                            controller: phoneController,
                          ),
                          SpacerHeight(h: 20),
                          RegularForm(
                            icon: 'assets/svg/new-id-card.svg',
                            title: "Sponsor ID",
                            hint: "Your Sponsor ID",
                            isValidator: false,
                            controller: sponsorIdController,
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
                          SpacerHeight(h: 20),
                          PasswordForm(
                            icon: 'assets/svg/new-password.svg',
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
                                style: CustomFont(CustomColor.blackColor, 12,
                                        FontWeight.w400)
                                    .font,
                              ),
                              GestureDetector(
                                child: Text(
                                  "Login here!",
                                  style: CustomFont(CustomColor.brownColor, 12,
                                          FontWeight.w400)
                                      .font,
                                ),
                                onTap: () {
                                  GoRouter.of(context).go('/login');
                                },
                              ),
                            ],
                          ),
                          SpacerHeight(h: 20),
                          SizedBox(
                            width: CustomScreen(context).width - 40,
                            child: CustomButton(
                              title: "Registration",
                              func: () async {
                                if (!formKey.currentState.validate()) {
                                  customSnackBar(context, true,
                                      "Complete the form first!");
                                } else {
                                  String name = nameController.text;
                                  String username = usernameController.text;
                                  String email = emailController.text;
                                  String phone = phoneController.text;
                                  String sponsorId = sponsorIdController.text;
                                  String password = passwordController.text;
                                  String confirmPassword =
                                      confirmPasswordController.text;
                                  if (password == confirmPassword) {
                                    await registrationPost(
                                            name,
                                            username,
                                            email,
                                            phone,
                                            sponsorId,
                                            password,
                                            confirmPassword)
                                        .then(
                                      (val) async {
                                        if (val['status'] == 200) {
                                          customSnackBar(context, false,
                                              val['message'].toString());
                                          GoRouter.of(context).go("/login");
                                        } else {
                                          customSnackBar(context, true,
                                              val['message'].toString());
                                        }
                                      },
                                    );
                                  } else {
                                    customSnackBar(
                                        context, true, 'Password not match!');
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
          ],
        ),
        // bottomNavigationBar: Container(
        //   color: CustomColor.whiteColor,
        //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        //   child: CustomButton(
        //     title: "Registration",
        //     func: () async {
        //       if (!formKey.currentState.validate()) {
        //         customSnackBar(context, true, "Complete the form first!");
        //       } else {
        //         String name = nameController.text;
        //         String username = usernameController.text;
        //         String email = emailController.text;
        //         String phone = phoneController.text;
        //         String sponsorId = sponsorIdController.text;
        //         String password = passwordController.text;
        //         String confirmPassword = confirmPasswordController.text;
        //         if (password == confirmPassword) {
        //           await registrationPost(name, username, email, phone,
        //                   sponsorId, password, confirmPassword)
        //               .then(
        //             (val) async {
        //               if (val['status'] == 200) {
        //                 customSnackBar(
        //                     context, false, val['message'].toString());
        //                 GoRouter.of(context).go("/login");
        //               } else {
        //                 customSnackBar(context, true, val['data'].toString());
        //               }
        //             },
        //           );
        //         } else {
        //           customSnackBar(context, true, 'Password not match!');
        //         }
        //       }
        //     },
        //   ),
        // ),
      ),
    );
  }
}
