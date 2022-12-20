// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/EHealth.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/EHealth.dart';

class EHealthDetail extends StatefulWidget {
  EHealthDetail(
      {Key key,
      this.name,
      this.height,
      this.weight,
      this.gender,
      this.age,
      this.id})
      : super(key: key);
  String name;
  String height;
  String weight;
  String gender;
  String age;
  String id;

  @override
  State<EHealthDetail> createState() => _EHealthDetailState();
}

class _EHealthDetailState extends State<EHealthDetail> {
  bool isLoad = true;

  int id;
  String name;
  String description;
  int disease_category_id;
  List<DiseaseProduct> product = [];

  String uname;
  String gender;
  String height;
  String weight;
  String age;

  getData(wid) async {
    await getDiseaseDetail(wid).then((val) {
      setState(() {
        id = val['data']['id'];
        name = val['data']['name'];
        description = val['data']['description'];
        disease_category_id = val['data']['disease_category_id'];
        for (var data in val['data']['disease_dt'] as List) {
          product.add(DiseaseProduct(
            id: data['disease_id'],
            disease_id: data['disease_id'],
            product_id: data['product_id'],
            reason: data['reason'],
            product_image: data['product']['product_image'][0]['image'],
            product_name: data['product']['name'],
            product_price: data['product']['price'],
          ));
        }
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    getData(widget.id);
    setState(() {
      uname = widget.name;
      gender = widget.gender;
      height = widget.height;
      weight = widget.weight;
      age = widget.age;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandartHeader(
        title: name ??= "",
        isPop: true,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: header(),
                  ),
                  SpacerHeight(h: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: body(),
                  ),
                  productRecommendation(),
                  SpacerHeight(h: 20),
                ],
              ),
            ),
    );
  }

  header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://wallpaperaccess.com/full/733834.png"),
                  ),
                ],
              ),
            ),
            SpacerWidth(w: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Height",
                        style: CustomFont(
                                CustomColor.blackColor, 14, FontWeight.bold)
                            .font,
                      ),
                      Text(
                        "$height cm",
                        style:
                            CustomFont(CustomColor.blackColor, 12, null).font,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weight",
                        style: CustomFont(
                                CustomColor.blackColor, 14, FontWeight.bold)
                            .font,
                      ),
                      Text(
                        "$weight kg",
                        style:
                            CustomFont(CustomColor.blackColor, 12, null).font,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: CustomFont(
                                CustomColor.blackColor, 14, FontWeight.bold)
                            .font,
                      ),
                      Text(
                        gender,
                        style:
                            CustomFont(CustomColor.blackColor, 12, null).font,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SpacerHeight(h: 10),
        Text(
          uname,
          style: CustomFont(CustomColor.blackColor, 14, FontWeight.bold).font,
        ),
        Text(
          "$age years old",
          style: CustomFont(CustomColor.blackColor, 12, null).font,
        ),
        SpacerHeight(h: 10),
        SizedBox(
          height: 50,
          width: CustomScreen(context).width,
          child: CustomButton(
            title: "Save to Lead",
            color: CustomColor.brownColor,
            func: () {
              GoRouter.of(context).push(
                  "/save-to-lead/$uname/$height/$weight/$gender/$age/$id");
            },
          ),
        ),
      ],
    );
  }

  body() {
    return Column(
      children: [
        Html(data: description ??= "..."),
      ],
    );
  }

  productRecommendation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Product Recommendations",
            style: CustomFont(CustomColor.brownColor, 16, FontWeight.bold).font,
          ),
        ),
        SpacerHeight(h: 20),
        (product.isEmpty)
            ? Center(
                child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Product Recommendation is Empty"),
              ))
            : SizedBox(
                width: CustomScreen(context).width,
                height: 210,
                child: (product == null)
                    ? Center(child: CupertinoActivityIndicator())
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: product.length,
                        clipBehavior: Clip.none,
                        itemBuilder: (BuildContext context, int index) {
                          DiseaseProduct prod = product[index];
                          return Row(
                            children: [
                              (0 == index)
                                  ? SizedBox(width: 20)
                                  : SizedBox(width: 0),
                              _sliderBox(
                                context,
                                prod.product_image ??=
                                    "https://wallpaperaccess.com/full/733834.png",
                                prod.product_name ??= "...",
                                prod.product_price ??= 0,
                                prod.id ??= 0,
                              ),
                              SizedBox(width: 20),
                            ],
                          );
                        },
                      ),
              ),
      ],
    );
  }

  _sliderBox(
      BuildContext context, String gambar, String name, int price, int id) {
    String sId = id.toString();
    return Container(
      width: 200,
      height: 220,
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 13,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            child: Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 13,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: gambar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () => GoRouter.of(context).push("/product-detail/$sId"),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CustomFont.bold12,
                        ),
                        SpacerHeight(h: 5),
                        Text(rupiah(price), style: CustomFont.regular12),
                      ],
                    ),
                  ),
                  SpacerWidth(w: 20),
                  InkWell(
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: CustomColor.brownColor,
                      ),
                      child: Icon(Icons.add, color: CustomColor.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
