// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:indonesia/indonesia.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/product.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/product.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var cart = FlutterCart();

  int product_id;
  String image;
  String name;
  String description;
  String usage;
  String ingredients;
  String benefits;
  int price;
  List review;

  int qty = 1;

  bool isLoad = true;

  getData() async {
    String id = widget.id.toString();
    await getProductDetail(id).then((val) {
      List list = [];
      for (var data in val['data']['product_testimonial'] as List) {
        list.add(ProductReview(
          id: data['id'],
          product_id: data['product_id'],
          subject: data['subject'],
          testimonial: data['testimonial'],
          image: data['image'],
        ));
      }
      setState(() {
        product_id = val['data']['id'];
        image = val['data']['product_image'][0]['image'];
        name = val['data']['name'];
        description = val['data']['description'];
        usage = val['data']['usage'];
        ingredients = val['data']['ingredients'];
        benefits = val['data']['benefits'];
        price = val['data']['price'];
        review = list;
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String harga = rupiah(price);
    return Scaffold(
      appBar: CustomHeader(
        // title: name ??= "",
        svgName: "cart-shopping-solid.svg",
        route: "/cart",
        isPop: true,
        offMiddleLogo: true,
        image: image ??= "https://wallpaperaccess.com/full/733834.png",
        height: 300,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                        "Description",
                        style:
                            CustomFont(CustomColor.oldGreyColor, 14, null).font,
                      ),
                      Text(
                        harga ??= "...",
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
                  ExpandableNotifier(
                    child: Column(
                      children: [
                        Expandable(
                          collapsed: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("How To Use",
                                      style: CustomFont(CustomColor.blackColor,
                                              14, FontWeight.w400)
                                          .font),
                                  ExpandableButton(
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: CustomColor.brownColor.withOpacity(0.5),
                              )
                            ],
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("How To Use",
                                      style: CustomFont(CustomColor.blackColor,
                                              14, FontWeight.w400)
                                          .font),
                                  ExpandableButton(
                                    child: Icon(
                                      Icons.remove,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: CustomColor.brownColor.withOpacity(0.5),
                              ),
                              Html(data: usage ??= "..."),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SpacerHeight(h: 10),

                  ExpandableNotifier(
                    child: Column(
                      children: [
                        Expandable(
                          collapsed: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Benefits",
                                      style: CustomFont(CustomColor.blackColor,
                                              14, FontWeight.w400)
                                          .font),
                                  ExpandableButton(
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: CustomColor.brownColor.withOpacity(0.5),
                              )
                            ],
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Benefits",
                                      style: CustomFont(CustomColor.blackColor,
                                              14, FontWeight.w400)
                                          .font),
                                  ExpandableButton(
                                    child: Icon(
                                      Icons.remove,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: CustomColor.brownColor.withOpacity(0.5),
                              ),
                              Html(data: benefits ??= "..."),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SpacerHeight(h: 10),

                  ExpandableNotifier(
                    child: Column(
                      children: [
                        Expandable(
                          collapsed: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Ingredients",
                                      style: CustomFont(CustomColor.blackColor,
                                              14, FontWeight.w400)
                                          .font),
                                  ExpandableButton(
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: CustomColor.brownColor.withOpacity(0.5),
                              )
                            ],
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Ingredients",
                                      style: CustomFont(CustomColor.blackColor,
                                              14, FontWeight.w400)
                                          .font),
                                  ExpandableButton(
                                    child: Icon(
                                      Icons.remove,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: CustomColor.brownColor.withOpacity(0.5),
                              ),
                              Html(data: ingredients ??= "..."),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SpacerHeight(h: 10),
                  ExpandableNotifier(
                    child: Column(
                      children: [
                        Expandable(
                          collapsed: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Reviews",
                                      style: CustomFont(CustomColor.blackColor,
                                              14, FontWeight.w400)
                                          .font),
                                  ExpandableButton(
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: CustomColor.brownColor.withOpacity(0.5),
                              )
                            ],
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Reviews",
                                      style: CustomFont(CustomColor.blackColor,
                                              14, FontWeight.w400)
                                          .font),
                                  ExpandableButton(
                                    child: Icon(
                                      Icons.remove,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: CustomColor.brownColor.withOpacity(0.5),
                              ),
                              (review == null)
                                  ? Text("")
                                  : ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: review.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        ProductReview list = review[index];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(7)),
                                                    child: CachedNetworkImage(
                                                      imageUrl: list.image ??=
                                                          "https://wallpaperaccess.com/full/733834.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SpacerWidth(w: 10),
                                                Text(
                                                  list.subject,
                                                  style: CustomFont(
                                                          CustomColor
                                                              .blackColor,
                                                          14,
                                                          FontWeight.bold)
                                                      .font,
                                                ),
                                              ],
                                            ),
                                            SpacerHeight(h: 10),
                                            Text(
                                              list.testimonial,
                                              style: CustomFont.regular12,
                                            ),
                                            SpacerHeight(h: 10),
                                          ],
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
          color: CustomColor.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        productId: product_id,
                        unitPrice: price,
                        productName: name,
                        productDetailsObject: image,
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
          )),
    );
  }
}
