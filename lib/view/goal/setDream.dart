// ignore_for_file: non_constant_identifier_names
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/goal.dart';
import 'package:revver/globals.dart';

class SetDream extends StatefulWidget {
  const SetDream({Key key}) : super(key: key);

  @override
  State<SetDream> createState() => _SetDreamState();
}

class _SetDreamState extends State<SetDream> {
  bool isLoad = true;
  bool isContain = true;
  final formKey = GlobalKey<FormState>();
  DateTime dateNow = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  getData() async {
    await getGoal().then((val) {
      if (val['status'] == 200) {
        setState(() {
          nameController.text = val['data']['target_title'];
          priceController.text = val['data']['target_point'].toString();
          dateNow = DateFormat('yyyy-MM-dd').parse(val['data']['target_date']);
          descriptionController.text = val['data']['target_description'];
          isLoad = false;
        });
      } else {
        setState(() {
          isLoad = false;
          isContain = false;
        });
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

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
        body: (isLoad)
            ? Center(child: CupertinoActivityIndicator())
            : Stack(
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
                        Text(
                          "Set Your Dream",
                          style: CustomFont(
                                  CustomColor.whiteColor, 32, FontWeight.w600)
                              .font,
                        )
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
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          )),
                          Container(
                            width: CustomScreen(context).width,
                            padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  SpacerHeight(h: 20),
                                  RegularForm(
                                    title: "What are you dream of?",
                                    hint: "eg: New Smartphone, Traveling",
                                    controller: nameController,
                                    isValidator: true,
                                  ),
                                  SpacerHeight(h: 20),
                                  RegularForm(
                                    title: "How much is it?",
                                    hint: "eg: 100000",
                                    controller: priceController,
                                    isValidator: true,
                                    keyboardType: TextInputType.number,
                                  ),
                                  SpacerHeight(h: 20),
                                  DateTimePickerForm(
                                    title: "When exactly do you want it?",
                                    hint: "t",
                                    date: dateNow,
                                    callback: (x) {
                                      setState(() => dateNow = x);
                                    },
                                  ),
                                  SpacerHeight(h: 20),
                                  MultiLineForm(
                                    title:
                                        "Describe why do you want it so bad?",
                                    hint: "eg: Remembering why you want it.",
                                    controller: descriptionController,
                                    isValidator: false,
                                  ),
                                  SpacerHeight(h: 20),
                                  (!isContain)
                                      ? SizedBox()
                                      : SizedBox(
                                          width: double.infinity,
                                          child: IconTextButton(
                                            title: "Delete Your Dream",
                                            iconTitle: "trash-can-solid.svg",
                                            buttonColor: CustomColor.redColor,
                                            func: () async {
                                              await deleteGoal().then((val) {
                                                if (val['status'] == 200) {
                                                  customSnackBar(context, false,
                                                      val['status'].toString());
                                                  GoRouter.of(context).pop();
                                                } else {
                                                  customSnackBar(context, true,
                                                      val['status'].toString());
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                  (!isContain)
                                      ? SizedBox()
                                      : SpacerHeight(h: 20),
                                  SizedBox(
                                    width: CustomScreen(context).width - 40,
                                    child: CustomButton(
                                      title: "Save Your Dream",
                                      func: () async {
                                        if (!formKey.currentState.validate()) {
                                          customSnackBar(context, true,
                                              "Complete the form first!");
                                        } else {
                                          String date = DateFormat('yyyy-MM-dd')
                                              .format(dateNow);
                                          if (isContain) {
                                            //patch
                                            await patchGoal(
                                              nameController.text,
                                              priceController.text,
                                              date,
                                              descriptionController.text,
                                            ).then((val) {
                                              if (val['status'] == 200) {
                                                customSnackBar(context, false,
                                                    val['status'].toString());
                                                GoRouter.of(context).pop();
                                              } else {
                                                customSnackBar(context, true,
                                                    val['status'].toString());
                                              }
                                            });
                                          } else {
                                            // post
                                            await postGoal(
                                              nameController.text,
                                              priceController.text,
                                              date,
                                              descriptionController.text,
                                            ).then((val) {
                                              if (val['status'] == 200) {
                                                customSnackBar(context, false,
                                                    val['status'].toString());
                                                GoRouter.of(context).pop();
                                              } else {
                                                customSnackBar(context, true,
                                                    val['status'].toString());
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
        //   color: CustomColor.backgroundColor,
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //   child: CustomButton(
        //     title: "Save Your Dream",
        //     func: () async {
        //       if (!formKey.currentState.validate()) {
        //         customSnackBar(context, true, "Complete the form first!");
        //       } else {
        //         String date = DateFormat('yyyy-MM-dd').format(dateNow);
        //         if (isContain) {
        //           //patch
        //           await patchGoal(
        //             nameController.text,
        //             priceController.text,
        //             date,
        //             descriptionController.text,
        //           ).then((val) {
        //             if (val['status'] == 200) {
        //               customSnackBar(context, false, val['status'].toString());
        //               GoRouter.of(context).pop();
        //             } else {
        //               customSnackBar(context, true, val['status'].toString());
        //             }
        //           });
        //         } else {
        //           // post
        //           await postGoal(
        //             nameController.text,
        //             priceController.text,
        //             date,
        //             descriptionController.text,
        //           ).then((val) {
        //             if (val['status'] == 200) {
        //               customSnackBar(context, false, val['status'].toString());
        //               GoRouter.of(context).pop();
        //             } else {
        //               customSnackBar(context, true, val['status'].toString());
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

// SingleChildScrollView(
//   padding: EdgeInsets.symmetric(horizontal: 20),
//   child: Form(
//     key: formKey,
//     child: Column(
//       children: [
//         SpacerHeight(h: 20),
//         RegularForm(
//           title: "What are you dream of?",
//           hint: "eg: New Smartphone, Traveling",
//           controller: nameController,
//           isValidator: true,
//         ),
//         SpacerHeight(h: 20),
//         RegularForm(
//           title: "How much is it?",
//           hint: "eg: 100000",
//           controller: priceController,
//           isValidator: true,
//           keyboardType: TextInputType.number,
//         ),
//         SpacerHeight(h: 20),
//         DateTimePickerForm(
//           title: "When exactly do you want it?",
//           hint: "t",
//           date: dateNow,
//           callback: (x) {
//             setState(() => dateNow = x);
//           },
//         ),
//         SpacerHeight(h: 20),
//         MultiLineForm(
//           title: "Describe why do you want it so bad?",
//           hint: "eg: Remembering why you want it.",
//           controller: descriptionController,
//           isValidator: false,
//         ),
//         SpacerHeight(h: 20),
//         (!isContain)
//             ? SizedBox()
//             : SizedBox(
//                 width: double.infinity,
//                 child: IconTextButton(
//                   title: "Delete Your Dream",
//                   iconTitle: "trash-can-solid.svg",
//                   buttonColor: CustomColor.redColor,
//                   func: () async {
//                     await deleteGoal().then((val) {
//                       if (val['status'] == 200) {
//                         customSnackBar(context, false,
//                             val['status'].toString());
//                         GoRouter.of(context).pop();
//                       } else {
//                         customSnackBar(context, true,
//                             val['status'].toString());
//                       }
//                     });
//                   },
//                 ),
//               ),
//       ],
//     ),
//   ),
// ),