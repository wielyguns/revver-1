// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
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
  int id;
  String priceValue = "0";
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  XFile image;
  final ImagePicker picker = ImagePicker();
  String imageString;

  getImage(ImageSource media) async {
    var img =
        await picker.pickImage(source: media, maxHeight: 480, maxWidth: 640);
    setState(() {
      image = img;
    });
  }

  getData() async {
    await getGoal().then((val) {
      if (val['status'] == 200) {
        if (val['data'] == null) {
          setState(() {
            isLoad = false;
            isContain = false;
          });
        } else {
          setState(() {
            id = val['data']['id'];
            imageString = val['data']['image'];
            nameController.text = val['data']['target_title'];
            priceValue = val['data']['target_point'].toString();
            dateNow =
                DateFormat('yyyy-MM-dd').parse(val['data']['target_date']);
            descriptionController.text = val['data']['target_description'];
            isLoad = false;
          });
        }
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
                    padding: EdgeInsets.only(left: 20, right: 20),
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
                        SpacerHeight(h: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Atur Mimpi Anda",
                              style: CustomFont(CustomColor.whiteColor, 26,
                                      FontWeight.w600)
                                  .font,
                            ),
                            image != null
                                ? GestureDetector(
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                    },
                                    child: SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        fit: StackFit.expand,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                FileImage(File(image.path)),
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
                                      height: 70,
                                      width: 70,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        fit: StackFit.expand,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                imageString ??=
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
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                      )),
                      Container(
                        width: CustomScreen(context).width,
                        height: CustomScreen(context).height / 1.3,
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        decoration: BoxDecoration(
                          color: CustomColor.whiteColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SpacerHeight(h: 20),
                                SpacerHeight(h: 20),
                                RegularForm(
                                  title: "Apa mimpi anda?",
                                  hint: "eg: Smartphone Baru, Traveling",
                                  controller: nameController,
                                  isValidator: true,
                                ),
                                SpacerHeight(h: 20),
                                CurrencyForm(
                                  title: "Berapa banyak?",
                                  hint: "eg: 100000",
                                  formValue: priceValue,
                                  isValidator: true,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  callback: (val) {
                                    setState(() {
                                      priceValue = val;
                                    });
                                  },
                                ),
                                SpacerHeight(h: 20),
                                DateOnlyPickerForm(
                                  icon: 'assets/svg/new-calendar-month.svg',
                                  title: "Kapan mimpi anda ingin diwujudkan?",
                                  hint: "t",
                                  date: dateNow,
                                  callback: (x) {
                                    setState(() => dateNow = x);
                                  },
                                ),
                                SpacerHeight(h: 20),
                                MultiLineForm(
                                  title:
                                      "Jelaskan kenapa anda menginginkannya?",
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
                                          title: "Hapus Mimpi Anda",
                                          iconTitle: "trash-can-solid.svg",
                                          buttonColor: CustomColor.redColor,
                                          func: () {
                                            deleteConfirmation(id);
                                            // await deleteGoal(id).then((val) {
                                            //   if (val['status'] == 200) {
                                            //     customSnackBar(context, false,
                                            //         val['status'].toString());
                                            //     GoRouter.of(context).pop();
                                            //   } else {
                                            //     customSnackBar(context, true,
                                            //         val['status'].toString());
                                            //   }
                                            // });
                                          },
                                        ),
                                      ),
                                (!isContain) ? SizedBox() : SpacerHeight(h: 20),
                                SizedBox(
                                  width: CustomScreen(context).width - 40,
                                  child: CustomButton(
                                    title: "Simpan Mimpi Anda",
                                    func: () async {
                                      onLoading(context);
                                      String newPrice = priceValue.replaceAll(
                                          RegExp(r'[^0-9]'), '');
                                      if (!formKey.currentState.validate()) {
                                        customSnackBar(context, true,
                                            "Complete the form first!");
                                      } else {
                                        String date = DateFormat('yyyy-MM-dd')
                                            .format(dateNow);
                                        if (isContain) {
                                          //patch
                                          if (image != null) {
                                            await postGoalImage(id.toString(),
                                                image.path, image.name);
                                          }
                                          await patchGoal(
                                            nameController.text,
                                            newPrice,
                                            date,
                                            descriptionController.text,
                                            id,
                                          ).then((val) {
                                            Navigator.pop(context);
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
                                          if (image != null) {
                                            await postGoalImage(id.toString(),
                                                image.path, image.name);
                                          }
                                          await postGoal(
                                            nameController.text,
                                            newPrice,
                                            date,
                                            descriptionController.text,
                                          ).then((val) {
                                            Navigator.pop(context);
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
                      ),
                    ],
                  ),
                ],
              ),
        // bottomNavigationBar: Container(
        //   color: CustomColor.backgroundColor,
        //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
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

  deleteConfirmation(glid) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peringatan'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Apakah anda yakin ingin menghapus Mimpi anda?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Tidak',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () async {
                await deleteGoal(glid).then((val) {
                  if (val['status'] == 200) {
                    Navigator.of(context).pop();
                    customSnackBar(context, false, val['status'].toString());
                    GoRouter.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    customSnackBar(context, true, val['status'].toString());
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }
}

// SingleChildScrollView(
//   padding: EdgeInsets.symmetric(horizontal: 35),
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