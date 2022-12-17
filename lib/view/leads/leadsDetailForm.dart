// ignore_for_file: unrelated_type_equality_checks

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
            ? CustomHeader(
                title: "Leads",
                isPop: true,
              )
            : PreferredSize(child: SizedBox(), preferredSize: Size(0, 0)),
        body: (isLoad)
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                      SpacerHeight(h: 30),
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
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          value: selectedItem,
          items: list.map((v) {
            return DropdownMenuItem(
              value: v,
              child: Text(
                v.name,
                style: CustomFont.filled,
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
          style: CustomFont.filled,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: CustomFont.hint,
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
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
                style: CustomFont.filled,
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
          style: CustomFont.filled,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: CustomFont.hint,
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
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
                style: CustomFont.filled,
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
          style: CustomFont.filled,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: CustomFont.hint,
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
          ),
        ),
      ],
    );
  }
}
