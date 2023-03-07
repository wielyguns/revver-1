// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/EHealth.dart';
import 'package:revver/controller/etc.dart';
import 'package:revver/controller/leads.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/EHealth.dart';
import 'package:revver/model/etc.dart';

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

  String id;

  TextEditingController nameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  String status;
  String financial;
  String ambition;
  String supel;
  String teachable;

  //Province&City
  List<Province> province = [];
  List<City> city = [];

  City selectedCity;
  Province selectedProvince;

  //Disease
  List<Disease> disease = [];
  Disease selectedDisease;

  List<String> gender = ['Male', 'Female'];
  String selectedGender;

  XFile image;
  final ImagePicker picker = ImagePicker();
  String avatar;

  bool isLoad = true;

  getImage(ImageSource media) async {
    var img =
        await picker.pickImage(source: media, maxHeight: 480, maxWidth: 640);
    setState(() {
      image = img;
    });
  }

  getData() async {
    await getLeadDetail(widget.id).then((val) async {
      String initProvince;
      String initCity;
      String initDisease;
      setState(() {
        initProvince = val['data']['province_id'].toString();
        initCity = val['data']['city_id'].toString();
        initDisease = val['data']['medical_record'][0]['disease_id'].toString();

        id = val['data']['id'].toString();

        nameController.text = val['data']['name'];
        heightController.text = val['data']['height'];
        weightController.text = val['data']['weight'];
        ageController.text = val['data']['age'];
        phoneController.text = val['data']['phone'];
        addressController.text = val['data']['address'];
        noteController.text = val['data']['note'];

        status = val['data']['status'];
        financial = val['data']['status_financial'];
        ambition = val['data']['status_ambition'];
        supel = val['data']['status_supel'];
        teachable = val['data']['status_teachable'];
        selectedGender = val['data']['gender'];

        avatar = val['data']['image'];
      });

      await getCity(initProvince).then((val) async {
        setState(() {
          city = val;
          List<City> x = city.where((e) => e.id == initCity).toList();
          selectedCity = x[0];
        });
        await getProvince().then((val) async {
          setState(() {
            province = val;
            List<Province> x =
                province.where((e) => e.id == initProvince).toList();
            selectedProvince = x[0];
          });
          await getDisease("", "").then((val) {
            setState(() {
              disease = val;
              List<Disease> x =
                  disease.where((e) => e.id == int.parse(initDisease)).toList();
              selectedDisease = x[0];
              isLoad = false;
            });
          });
        });
      });
    });
  }

  getInitForm() async {
    await getProvince().then((val) async {
      setState(() {
        province = val;
      });
      await getDisease("", "").then((val) {
        setState(() {
          disease = val;
          isLoad = false;
        });
      });
    });
  }

  getCityList(id) async {
    await getCity(id).then((val) {
      setState(() {
        city = val;
      });
    });
  }

  getDiseaseList() async {}

  @override
  void initState() {
    super.initState();
    if (widget.x != null) {
      getData();
    } else {
      getInitForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: (widget.x == null)
            ? AppBar(
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
              )
            : PreferredSize(child: SizedBox(), preferredSize: Size(0, 0)),
        body: (isLoad)
            ? Center(child: CupertinoActivityIndicator())
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 35),
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
                                "Leads",
                                style: CustomFont(CustomColor.whiteColor, 32,
                                        FontWeight.w600)
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
                                                        backgroundImage:
                                                            FileImage(File(
                                                                image.path)),
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
                                                        backgroundImage:
                                                            NetworkImage(avatar ??=
                                                                "https://wallpaperaccess.com/full/733834.png"),
                                                      ),
                                                      Icon(
                                                        Icons.edit,
                                                        size: 20,
                                                        color: CustomColor
                                                            .whiteColor,
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
                      SpacerHeight(h: 10),
                      RegularForm(
                        icon: 'assets/svg/new-user-edit.svg',
                        title: "Full Name",
                        hint: "Your Full Name",
                        controller: nameController,
                      ),
                      SpacerHeight(h: 20),
                      StringDropdown(
                        icon: 'assets/svg/new-user.svg',
                        title: "Lead Status",
                        hint: "Lead Status",
                        list: leadStatus,
                        value: status,
                        callback: (val) {
                          setState(() {
                            status = val;
                          });
                        },
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
                              value: financial,
                              callback: (val) {
                                setState(() {
                                  financial = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: CustomScreen(context).width / 5,
                            child: StringDropdown(
                              title: "Ambition",
                              hint: "Set",
                              list: score,
                              value: ambition,
                              callback: (val) {
                                setState(() {
                                  ambition = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: CustomScreen(context).width / 5,
                            child: StringDropdown(
                              title: "Supel",
                              hint: "Set",
                              list: score,
                              value: supel,
                              callback: (val) {
                                setState(() {
                                  supel = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: CustomScreen(context).width / 5,
                            child: StringDropdown(
                              title: "Teachable",
                              hint: "Set",
                              list: score,
                              value: teachable,
                              callback: (val) {
                                setState(() {
                                  teachable = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SpacerHeight(h: 20),
                      diseaseDropdown(
                        "Medical Record",
                        "Your Medical Record",
                        disease,
                        selectedDisease,
                      ),
                      SpacerHeight(h: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   width: CustomScreen(context).width / 4,
                          //   child: RegularForm(
                          //     title: "Height",
                          //     hint: "eg: 160",
                          //     controller: heightController,
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: CustomScreen(context).width / 4,
                          //   child: RegularForm(
                          //     title: "Weight",
                          //     hint: "eg: 60",
                          //     controller: weightController,
                          //   ),
                          // ),
                          SizedBox(
                            width: CustomScreen(context).width / 2,
                            child: StringDropdown(
                              title: "Jenis Kelamin",
                              hint: "Male / Female",
                              list: gender,
                              value: selectedGender,
                              callback: (val) {
                                selectedGender = val;
                              },
                            ),
                          ),
                          SizedBox(
                            width: CustomScreen(context).width / 4,
                            child: RegularForm(
                              title: "Umur",
                              hint: "eg: 20",
                              controller: ageController,
                            ),
                          ),
                        ],
                      ),
                      SpacerHeight(h: 20),
                      RegularForm(
                        icon: 'assets/svg/new-phone.svg',
                        title: "Nomor Telepon",
                        hint: "Your Phone",
                        controller: phoneController,
                      ),
                      SpacerHeight(h: 20),
                      provinceDropdown("Provinsi", "Your Province", province,
                          selectedProvince),
                      (city.isEmpty) ? SizedBox() : SpacerHeight(h: 20),
                      (city.isEmpty)
                          ? SizedBox()
                          : cityDropdown(
                              "Kota",
                              "Your City",
                              city,
                              selectedCity,
                            ),
                      SpacerHeight(h: 20),
                      RegularForm(
                        icon: 'assets/svg/new-location.svg',
                        title: "Alamat",
                        hint: "Your Address",
                        controller: addressController,
                      ),
                      SpacerHeight(h: 20),
                      MultiLineForm(
                        title: "Note",
                        hint: "Your Note",
                        controller: noteController,
                      ),
                      (widget.x == null) ? SizedBox() : SpacerHeight(h: 30),
                      (widget.x == null)
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    title: "Delete Account",
                                    color: CustomColor.redColor,
                                    func: () async {
                                      await deleteLeads(id).then((val) {
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
                              ],
                            ),
                      SpacerHeight(h: 20),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: Container(
          color: CustomColor.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: CustomButton(
            title: "Save",
            func: () async {
              String imgpath = image?.path ?? "";
              String imgname = image?.name ?? "";

              if (widget.x == null) {
                await postLeadDetail(
                  nameController.text,
                  phoneController.text,
                  status,
                  financial,
                  ambition,
                  supel,
                  teachable,
                  heightController.text,
                  weightController.text,
                  ageController.text,
                  selectedProvince.id.toString(),
                  selectedCity.id.toString(),
                  addressController.text,
                  noteController.text,
                  selectedDisease.id.toString(),
                  imgpath,
                  imgname,
                  selectedGender,
                ).then((val) {
                  if (val == 200) {
                    customSnackBar(context, false, val.toString());
                    GoRouter.of(context).pop();
                  } else {
                    customSnackBar(context, true, val.toString());
                  }
                });
              } else {
                await patchLeadDetail(
                  id,
                  nameController.text,
                  phoneController.text,
                  status,
                  financial,
                  ambition,
                  supel,
                  teachable,
                  heightController.text,
                  weightController.text,
                  ageController.text,
                  selectedProvince.id.toString(),
                  selectedCity.id.toString(),
                  addressController.text,
                  noteController.text,
                  selectedDisease.id.toString(),
                  imgpath,
                  imgname,
                  selectedGender,
                ).then((val) {
                  if (val == 200) {
                    customSnackBar(context, false, val.toString());
                    GoRouter.of(context).pop();
                  } else {
                    customSnackBar(context, true, val.toString());
                  }
                });
              }

              // if (image != null) {}
            },
          ),
        ),
      ),
    );
  }

  Widget provinceDropdown(
    String title,
    String hint,
    List<Province> list,
    Province selectedItem,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomFont.regular12),
        SizedBox(height: 10),
        DropdownButtonFormField(
          isExpanded: true,
          value: selectedItem,
          items: list.map((v) {
            return DropdownMenuItem(
              value: v,
              child: Text(
                v.name,
                style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400)
                    .font,
              ),
            );
          }).toList(),
          onChanged: (val) async {
            setState(() {
              selectedItem = val;
              selectedProvince = val;
              selectedCity = null;
              city = [];
            });
            await getCityList(selectedItem.id);
          },
          dropdownColor: CustomColor.whiteColor,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: SvgPicture.asset(
              'assets/svg/new-city.svg',
              width: 28,
              height: 28,
              fit: BoxFit.scaleDown,
              color: CustomColor.brownColor,
            ),
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget cityDropdown(
    String title,
    String hint,
    List<City> list,
    City selectedItem,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomFont.regular12),
        SizedBox(height: 10),
        DropdownButtonFormField(
          isExpanded: true,
          value: selectedItem,
          items: list.map((v) {
            return DropdownMenuItem(
              value: v,
              child: Text(
                v.name,
                style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400)
                    .font,
              ),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              selectedItem = val;
              selectedCity = val;
            });
          },
          dropdownColor: CustomColor.whiteColor,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: SvgPicture.asset(
              'assets/svg/new-city.svg',
              width: 28,
              height: 28,
              fit: BoxFit.scaleDown,
              color: CustomColor.brownColor,
            ),
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget diseaseDropdown(
    String title,
    String hint,
    List<Disease> list,
    Disease selectedItem,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomFont.regular12),
        SizedBox(height: 10),
        DropdownButtonFormField(
          isExpanded: true,
          value: selectedItem,
          items: list.map((v) {
            return DropdownMenuItem(
              value: v,
              child: Text(
                v.name,
                style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400)
                    .font,
              ),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              selectedItem = val;
              selectedDisease = val;
            });
          },
          dropdownColor: CustomColor.whiteColor,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: SvgPicture.asset(
              'assets/svg/new-id-card.svg',
              width: 28,
              height: 28,
              fit: BoxFit.scaleDown,
              color: CustomColor.brownColor,
            ),
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
        ),
      ],
    );
  }
}
