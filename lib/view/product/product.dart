import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/test.dart';
import 'package:revver/globals.dart';

class Product extends StatefulWidget {
  const Product({Key key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "News & Updates",
        isPop: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView.separated(
          separatorBuilder: ((context, index) {
            return SpacerHeight(h: 10);
          }),
          itemCount: 10,
          itemBuilder: (context, index) {
            return newsWidget();
          },
        ),
      ),
    );
  }

  newsWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: CustomColor.oldGreyColor)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => GoRouter.of(context).push("/product-detail"),
            child: SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: "https://wallpaperaccess.com/full/733834.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => GoRouter.of(context).push("/product-detail"),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                      style: CustomFont.bold12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("data", style: CustomFont.regular10),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => test(context),
            child: Container(
              margin: EdgeInsets.all(10),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: CustomColor.goldColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SvgPicture.asset(
                  "assets/svg/cart-shopping-solid.svg",
                  color: CustomColor.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
