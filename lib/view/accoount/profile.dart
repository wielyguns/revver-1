import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
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
  int id;
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
    var img =
        await picker.pickImage(source: media, maxHeight: 480, maxWidth: 640);
    setState(() {
      image = img;
    });
  }

  getData() async {
    await getAccountProfile().then((val) {
      setState(() {
        id = val['data']['id'];
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
        appBar: AppBar(
          leading: CupertinoNavigationBarBackButton(
            onPressed: (() => GoRouter.of(context).pop()),
          ),
          centerTitle: true,
          title: Image.asset(
            "assets/img/revver-horizontal.png",
            width: CustomScreen(context).width / 3,
          ),
          backgroundColor: CustomColor.backgroundColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SpacerHeight(h: 20),
                Stack(
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/revver-bg.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Profile",
                          style: CustomFont(
                                  CustomColor.whiteColor, 32, FontWeight.w600)
                              .font,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SpacerHeight(h: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColor.whiteColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: EdgeInsets.all(5),
                              height: 80,
                              width: 80,
                              child: Stack(
                                clipBehavior: Clip.none,
                                fit: StackFit.expand,
                                children: [
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
                                                  backgroundImage: FileImage(
                                                      File(image.path)),
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
                                                  backgroundImage: NetworkImage(
                                                      avatar ??=
                                                          "https://wallpaperaccess.com/full/733834.png"),
                                                ),
                                                Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: CustomColor.whiteColor,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                // SpacerHeight(h: 20),
                // image != null
                //     ? GestureDetector(
                //         onTap: () {
                //           getImage(ImageSource.gallery);
                //         },
                //         child: SizedBox(
                //           height: 80,
                //           width: 80,
                //           child: Stack(
                //             clipBehavior: Clip.none,
                //             fit: StackFit.expand,
                //             children: [
                //               CircleAvatar(
                //                 backgroundImage: FileImage(File(image.path)),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     : GestureDetector(
                //         onTap: () {
                //           getImage(ImageSource.gallery);
                //         },
                //         child: SizedBox(
                //           height: 80,
                //           width: 80,
                //           child: Stack(
                //             clipBehavior: Clip.none,
                //             fit: StackFit.expand,
                //             children: [
                //               CircleAvatar(
                //                 backgroundImage: NetworkImage(avatar ??=
                //                     "https://wallpaperaccess.com/full/733834.png"),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                SpacerHeight(h: 5),
                RegularForm(
                  title: "Full Name",
                  hint: "Your Full Name",
                  isValidator: false,
                  controller: nameController,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Username",
                  hint: "Your Username",
                  isValidator: false,
                  controller: usernameController,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Sponsor ID",
                  hint: "Your Sponsor ID",
                  isValidator: false,
                  controller: sponsorIdController,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Phone",
                  hint: "Your Phone",
                  isValidator: false,
                  controller: phoneController,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Email",
                  hint: "Your Email",
                  isValidator: false,
                  readOnly: true,
                  controller: emailController,
                ),
                SpacerHeight(h: 20),
                RegularForm(
                  title: "Secondary Email",
                  hint: "Your Secondary Email",
                  isValidator: false,
                  controller: secondaryEmailController,
                ),
                SpacerHeight(h: 30),
                Row(
                  children: [
                    Expanded(
                      child: IconTextButton(
                        buttonColor: CustomColor.backgroundColor,
                        borderColor: CustomColor.brownColor,
                        textColor: CustomColor.brownColor,
                        title: "Delete Account",
                        func: () async {
                          await deleteAccount(id).then((val) {
                            if (val['status'] == 200) {
                              GoRouter.of(context).go('/login');
                            } else {
                              customSnackBar(context, true, val['message']);
                            }
                          });
                        },
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
          color: CustomColor.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: IconTextButton(
            buttonColor: CustomColor.brownColor,
            title: "Save",
            func: () async {
              if (image != null) {
                await postChangeAvatar(image.path, image.name).then((val) {
                  String res = val.toString();
                  if (val == 200) {
                    customSnackBar(
                        context, false, 'Succes: Update Image ($res)');
                  } else {
                    customSnackBar(context, true, "Error: Update Image ($res)");
                  }
                });
              }
              patchAccountProfile(nameController.text, usernameController.text,
                      phoneController.text, secondaryEmailController.text)
                  .then((val) {
                if (val['status'] == 200) {
                  GoRouter.of(context).pop();
                } else {
                  customSnackBar(context, true, val['message']);
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
