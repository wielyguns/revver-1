// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/EHealth.dart';
import 'package:revver/controller/etc.dart';
import 'package:revver/controller/leads.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/EHealth.dart';
import 'package:revver/model/etc.dart';

class SaveToLead extends StatefulWidget {
  SaveToLead(
      {Key key,
      this.name,
      this.height,
      this.weight,
      this.gender,
      this.age,
      this.disease_id})
      : super(key: key);
  String name;
  String height;
  String weight;
  String gender;
  String age;
  String disease_id;

  @override
  State<SaveToLead> createState() => _SaveToLeadState();
}

class _SaveToLeadState extends State<SaveToLead> {
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

  getData(did) async {
    await getDisease("", "").then((val) {
      setState(() {
        disease = val;
        List<Disease> x = disease.where((e) => e.id == int.parse(did)).toList();
        selectedDisease = x[0];
        isLoad = false;
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

  getProvinceList() async {
    await getProvince().then((val) async {
      setState(() {
        province = val;
      });
    });
  }

  @override
  void initState() {
    getProvinceList();
    super.initState();
    setState(() {
      nameController.text = widget.name;
      heightController.text = widget.height;
      weightController.text = widget.weight;
      ageController.text = widget.age;
    });
    getData(widget.disease_id);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomHeader(
          title: "Leads",
          isPop: true,
        ),
        body: (isLoad)
            ? Center(child: CupertinoActivityIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 35),
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
                        controller: nameController,
                      ),
                      SpacerHeight(h: 20),
                      StringDropdown(
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
                          SizedBox(
                            width: CustomScreen(context).width / 4,
                            child: RegularForm(
                              title: "Height",
                              hint: "eg: 160",
                              controller: heightController,
                            ),
                          ),
                          SizedBox(
                            width: CustomScreen(context).width / 4,
                            child: RegularForm(
                              title: "Weight",
                              hint: "eg: 60",
                              controller: weightController,
                            ),
                          ),
                          SizedBox(
                            width: CustomScreen(context).width / 4,
                            child: RegularForm(
                              title: "Age",
                              hint: "eg: 20",
                              controller: ageController,
                            ),
                          ),
                        ],
                      ),
                      SpacerHeight(h: 20),
                      RegularForm(
                        title: "Phone",
                        hint: "Your Phone",
                        controller: phoneController,
                      ),
                      SpacerHeight(h: 20),
                      provinceDropdown("Province", "Your Province", province,
                          selectedProvince),
                      (city.isEmpty) ? SizedBox() : SpacerHeight(h: 20),
                      (city.isEmpty)
                          ? SizedBox()
                          : cityDropdown(
                              "City",
                              "Your City",
                              city,
                              selectedCity,
                            ),
                      SpacerHeight(h: 20),
                      RegularForm(
                        title: "Address",
                        hint: "Your Address",
                        controller: addressController,
                      ),
                      SpacerHeight(h: 20),
                      MultiLineForm(
                        title: "Note",
                        hint: "Your Note",
                        controller: noteController,
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
              ).then((val) {
                if (val == 200) {
                  customSnackBar(context, false, val.toString());
                  GoRouter.of(context).push('/homepage/0');
                } else {
                  customSnackBar(context, true, val.toString());
                }
              });
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
