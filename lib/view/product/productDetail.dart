import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:indonesia/indonesia.dart';
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
  int product_id;
  String image;
  String name;
  String description;
  String usage;
  String ingredients;
  String benefits;
  int price;
  List review;

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
        title: name ??= "",
        isPop: true,
      ),
      body: (isLoad)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpacerHeight(h: 20),
                  SizedBox(
                    width: CustomScreen(context).width,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      child: CachedNetworkImage(
                        imageUrl: image ??=
                            "https://wallpaperaccess.com/full/733834.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SpacerHeight(h: 20),
                  Text(
                    name ??= "...",
                    style: CustomFont.regular18,
                  ),
                  Text(
                    harga ??= "...",
                    style: CustomFont.bold18,
                  ),
                  SpacerHeight(h: 20),
                  Text(
                    "Description",
                    style: CustomFont.medium12,
                  ),
                  Html(data: description ??= "..."),
                  SpacerHeight(h: 20),
                  Text(
                    "How To Use",
                    style: CustomFont.medium12,
                  ),
                  Html(data: usage ??= "..."),
                  SpacerHeight(h: 20),
                  Text(
                    "Benefits",
                    style: CustomFont.medium12,
                  ),
                  Html(data: benefits ??= "..."),
                  SpacerHeight(h: 20),
                  Text(
                    "ingredients",
                    style: CustomFont.medium12,
                  ),
                  Html(data: ingredients ??= "..."),
                  SpacerHeight(h: 20),
                  Text(
                    "Reviews",
                    style: CustomFont.medium12,
                  ),
                  (review == null) ? Text("ss") : Text("xx"),
                ],
              ),
            ),
    );
  }
}
