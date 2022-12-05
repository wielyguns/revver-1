import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/account.dart';
import 'package:revver/controller/leads.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class LeadsDetailForm extends StatefulWidget {
  LeadsDetailForm({Key key, this.x, this.id}) : super(key: key);
  String x;
  int id;

  @override
  State<LeadsDetailForm> createState() => _LeadsDetailFormState();
}

class _LeadsDetailFormState extends State<LeadsDetailForm> {
  List<String> leadStatus = ['Cold', 'Warm', 'Hot', 'Converted'];
  List<String> score = ['1', '2', '3'];
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
    var img =
        await picker.pickImage(source: media, maxHeight: 480, maxWidth: 640);
    setState(() {
      image = img;
    });
  }

  getData() async {
    await getLeadDetail(widget.id).then((val) {
      print(val);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.x == null)
          ? CustomHeader(
              title: "Leads",
              isPop: true,
            )
          : PreferredSize(child: SizedBox(), preferredSize: Size(0, 0)),
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
              ),
              SpacerHeight(h: 20),
              StringDropdown(
                title: "Lead Status",
                hint: "Lead Status",
                list: leadStatus,
              ),
              SpacerHeight(h: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: CustomScreen(context).width / 5,
                    child: StringDropdown(
                      title: "Financial",
                      hint: "Set",
                      list: score,
                    ),
                  ),
                  SizedBox(
                    width: CustomScreen(context).width / 5,
                    child: StringDropdown(
                      title: "Ambition",
                      hint: "Set",
                      list: score,
                    ),
                  ),
                  SizedBox(
                    width: CustomScreen(context).width / 5,
                    child: StringDropdown(
                      title: "Supel",
                      hint: "Set",
                      list: score,
                    ),
                  ),
                  SizedBox(
                    width: CustomScreen(context).width / 5,
                    child: StringDropdown(
                      title: "Teachable",
                      hint: "Set",
                      list: score,
                    ),
                  ),
                ],
              ),
              SpacerHeight(h: 20),
              StringDropdown(
                title: "Medical Record",
                hint: "Your Medical Record",
                list: leadStatus,
              ),
              SpacerHeight(h: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: CustomScreen(context).width / 4,
                    child: RegularForm(
                      title: "Height",
                      hint: "eg: 160",
                    ),
                  ),
                  SizedBox(
                    width: CustomScreen(context).width / 4,
                    child: RegularForm(
                      title: "Weight",
                      hint: "eg: 60",
                    ),
                  ),
                  SizedBox(
                    width: CustomScreen(context).width / 4,
                    child: RegularForm(
                      title: "Age",
                      hint: "eg: 20",
                    ),
                  ),
                ],
              ),
              SpacerHeight(h: 20),
              RegularForm(
                title: "Phone",
                hint: "Your Phone",
              ),
              SpacerHeight(h: 20),
              StringDropdown(
                title: "Province",
                hint: "Your Province",
                list: leadStatus,
              ),
              SpacerHeight(h: 20),
              StringDropdown(
                title: "City",
                hint: "Your City",
                list: leadStatus,
              ),
              SpacerHeight(h: 20),
              RegularForm(
                title: "Address",
                hint: "Your Address",
              ),
              SpacerHeight(h: 20),
              MultiLineForm(
                title: "Note",
                hint: "Your Note",
              ),
              SpacerHeight(h: 30),
              (widget.x == null)
                  ? SizedBox()
                  : Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            title: "Delete Account",
                            color: CustomColor.redColor,
                            func: () async {},
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
            if (image != null) {
              await postChangeAvatar(image.path, image.name).then((val) {
                String res = val.toString();
                if (val == 200) {
                  customSnackBar(context, false, 'Succes: Update Image ($res)');
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
    );
  }
}
