import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/etc.dart';
import 'package:revver/controller/leads.dart';
import 'package:revver/globals.dart';
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
  List<Province> province = [];
  List<City> city = [];
  final formKey = GlobalKey<FormState>();

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

  String initProvince;
  String initCity;

  String initProvinceName;
  String initCityName;

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
      setState(() {
        initProvince = val['data']['province_id'].toString();
        initCity = val['data']['city_id'].toString();

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
      });

      await getCityList(initCity).then((val) async {
        await getProvince().then((val) {
          isLoad = false;
        });
      });
    });
  }

  getProvinceList() async {
    await getProvince().then((val) {
      setState(() {
        province = val;
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

  @override
  void initState() {
    super.initState();
    if (widget.x != null) {
      getData();
    } else {
      getProvinceList();
    }
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
                          ),
                        ),
                        SizedBox(
                          width: CustomScreen(context).width / 5,
                          child: StringDropdown(
                            title: "Ambition",
                            hint: "Set",
                            list: score,
                            value: ambition,
                          ),
                        ),
                        SizedBox(
                          width: CustomScreen(context).width / 5,
                          child: StringDropdown(
                            title: "Supel",
                            hint: "Set",
                            list: score,
                            value: supel,
                          ),
                        ),
                        SizedBox(
                          width: CustomScreen(context).width / 5,
                          child: StringDropdown(
                            title: "Teachable",
                            hint: "Set",
                            list: score,
                            value: teachable,
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
                    DynamicDropdown(
                      list: province,
                      title: "Province",
                      hint: initProvince ??= "Your Province",
                      callback: (val) async {
                        await getCityList(val);
                      },
                    ),
                    SpacerHeight(h: 20),
                    DynamicDropdown(
                      list: city,
                      title: "City",
                      hint: initCityName ??= "Your City",
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
            if (image != null) {}
          },
        ),
      ),
    );
  }
}
