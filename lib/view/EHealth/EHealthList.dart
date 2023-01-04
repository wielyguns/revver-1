// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/EHealth.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/EHealth.dart';

class EHealthList extends StatefulWidget {
  EHealthList(
      {Key key, this.name, this.height, this.weight, this.gender, this.age})
      : super(key: key);
  String name;
  String height;
  String weight;
  String gender;
  String age;

  @override
  State<EHealthList> createState() => _EHealthListState();
}

class _EHealthListState extends State<EHealthList> {
  bool isLoad = true;
  bool isLoadCategory = true;
  List<Disease> disease = [];
  List<DiseaseCategory> diseaseCategory = [];
  TextEditingController searchController = TextEditingController();
  DiseaseCategory selectedCategory;

  getData() async {
    setState(() {
      isLoad = true;
    });
    String sc;
    if (selectedCategory == null) {
      sc = "";
    } else {
      if (selectedCategory.id == 0) {
        sc = "";
      } else {
        sc = selectedCategory.id.toString();
      }
    }

    await getDisease(searchController.text, sc).then((val) {
      setState(() {
        disease = val;
        disease.sort((a, b) => a.name.compareTo(b.name));
        isLoad = false;
      });
    });
  }

  getCategory() async {
    await getDiseaseCategory().then((val) {
      setState(() {
        diseaseCategory = val;
        diseaseCategory
            .add(DiseaseCategory(id: 0, name: "All Categories", image: ""));
        diseaseCategory.sort((a, b) => a.id.compareTo(b.id));
        isLoadCategory = false;
      });
    });
  }

  @override
  void initState() {
    getCategory();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomHeader(
          title: "E-Health",
          isPop: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SpacerHeight(h: 20),
              (isLoadCategory)
                  ? Center(child: LinearProgressIndicator())
                  : listCategory(),
              SpacerHeight(h: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SearchForm(
                  controller: searchController,
                  callback: () {
                    getData();
                  },
                ),
              ),
              SpacerHeight(h: 20),
              (isLoad)
                  ? Center(child: LinearProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: listDisease(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  listCategory() {
    return SizedBox(
      height: 40,
      width: CustomScreen(context).width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: diseaseCategory.length,
        itemBuilder: ((context, index) {
          DiseaseCategory dc = diseaseCategory[index];
          return Row(
            children: [
              (index == 0) ? SpacerWidth(w: 20) : SizedBox(),
              GestureDetector(
                onTap: (() {
                  setState(() {
                    selectedCategory = dc;
                    getData();
                  });
                }),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColor.oldGreyColor),
                    borderRadius: BorderRadius.circular(20),
                    color: (selectedCategory == dc)
                        ? CustomColor.brownColor
                        : CustomColor.backgroundColor,
                  ),
                  child: Text(
                    dc.name,
                    style: CustomFont(
                            (selectedCategory == dc)
                                ? CustomColor.backgroundColor
                                : CustomColor.blackColor,
                            12,
                            FontWeight.bold)
                        .font,
                  ),
                ),
              ),
              SpacerWidth(w: 20),
            ],
          );
        }),
      ),
    );
  }

  listDisease() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: disease.length,
      itemBuilder: ((context, index) {
        Disease ds = disease[index];
        return GestureDetector(
          onTap: () {
            String name = widget.name;
            String height = widget.height;
            String weight = widget.weight;
            String gender = widget.gender;
            String age = widget.age;
            String id = ds.id.toString();
            GoRouter.of(context).push(
                "/e-health-detail/$name/$height/$weight/$gender/$age/$id");
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ds.name),
                (disease.length - 1 == index) ? SpacerHeight(h: 10) : SizedBox()
              ],
            ),
          ),
        );
      }),
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1,
          color: CustomColor.greyColor,
        );
      },
    );
  }
}
