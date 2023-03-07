// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:indonesia/indonesia.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/ELearning.dart';
import 'package:revver/globals.dart';

class ELearningDetail extends StatefulWidget {
  ELearningDetail({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<ELearningDetail> createState() => _ELearningDetailState();
}

class _ELearningDetailState extends State<ELearningDetail> {
  var cart = FlutterCart();

  bool isLoad = true;

  int id;
  String name;
  String description;
  String thumbnail;
  int price;

  int qty = 1;

  getData(id) async {
    await getELearningDetail(id).then((val) async {
      setState(() {
        name = val['data']['name'];
        description = val['data']['description'];
        thumbnail = val['data']['thumbnail'];
        price = val['data']['price'];
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    getData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String harga = rupiah(price);
    return Scaffold(
      appBar: CustomHeader(
        title: name ??= "",
        svgName: "new-cart.svg",
        route: "/cart",
        isPop: true,
        offMiddleLogo: true,
        image: thumbnail ??= "https://wallpaperaccess.com/full/733834.png",
        height: 300,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SpacerHeight(h: 20),
                  // SizedBox(
                  //   width: CustomScreen(context).width,
                  //   height: 200,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.all(Radius.circular(32)),
                  //     child: CachedNetworkImage(
                  //       imageUrl: image ??=
                  //           "https://wallpaperaccess.com/full/733834.png",
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  SpacerHeight(h: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Deskripsi",
                        style:
                            CustomFont(CustomColor.oldGreyColor, 14, null).font,
                      ),
                      Text(
                        harga ??= "",
                        style: CustomFont(
                                CustomColor.brownColor, 24, FontWeight.w700)
                            .font,
                      ),
                    ],
                  ),
                  SpacerHeight(h: 10),
                  Text(
                    name ??= "...",
                    style:
                        CustomFont(CustomColor.blackColor, 30, FontWeight.w700)
                            .font,
                  ),
                  SpacerHeight(h: 20),
                  Html(data: description ??= "..."),
                  SpacerHeight(h: 20),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        color: CustomColor.backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (qty == 1) {
                    qty = 1;
                  } else {
                    qty -= 1;
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColor.oldGreyColor,
                ),
                child: Icon(
                  Icons.remove,
                  size: 18,
                  color: CustomColor.whiteColor,
                ),
              ),
            ),
            SizedBox(
              width: 30,
              child: Text(
                "$qty",
                // "1",
                style: CustomFont(CustomColor.blackColor, 15, FontWeight.w600)
                    .font,
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  qty += 1;
                });
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColor.brownColor,
                ),
                child: Icon(
                  Icons.add,
                  size: 18,
                  color: CustomColor.whiteColor,
                ),
              ),
            ),
            SpacerWidth(w: 20),
            Expanded(
              child: CupertinoButton(
                padding: EdgeInsets.all(10),
                minSize: 50,
                onPressed: () {
                  cart.addToCart(
                      productId: widget.id,
                      unitPrice: price,
                      productName: name,
                      productDetailsObject: thumbnail,
                      quantity: qty);
                },
                color: CustomColor.brownColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add To Cart",
                      style: CustomFont(
                              CustomColor.whiteColor, 16, FontWeight.w600)
                          .font,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
