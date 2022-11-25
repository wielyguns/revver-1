import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/account.dart';
import 'package:revver/globals.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController sponsorIdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController secondaryEmailController = TextEditingController();
  XFile image;
  final ImagePicker picker = ImagePicker();
  String avatar;

  getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  getData() async {
    await getAccountProfile().then((val) {
      setState(() {
        nameController.text = val['data']['name'];
        usernameController.text = val['data']['username'];
        sponsorIdController.text = val['data']['sponsor']['name'];
        phoneController.text = val['data']['phone'];
        emailController.text = val['data']['email'];
        secondaryEmailController.text = val['data']['secondary_email'];
        avatar = val['data']['avatar'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
                image != null
                    ? GestureDetector(
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundImage: FileImage(File(image.path)),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          getImage(ImageSource.gallery);
                        },
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(avatar ??=
                                    "https://wallpaperaccess.com/full/733834.png"),
                              ),
                            ],
                          ),
                        ),
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
                  title: "Sponsor ID",
                  hint: "Your Sponsor ID",
                  isValidator: true,
                  controller: sponsorIdController,
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
                  title: "Email",
                  hint: "Your Email",
                  isValidator: true,
                  readOnly: true,
                  controller: emailController,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Secondary Email",
                  hint: "Your Secondary Email",
                  isValidator: true,
                  controller: secondaryEmailController,
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
