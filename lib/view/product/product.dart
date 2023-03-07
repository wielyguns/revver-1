import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/product.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/product.dart' as p;

class Product extends StatefulWidget {
  const Product({Key key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var cart = FlutterCart();
  TextEditingController searchController = TextEditingController();
  List product;
  bool isLoad = true;

  getData() async {
    setState(() {
      isLoad = true;
    });
    await getProduct(searchController.text).then((val) {
      setState(() {
        product = val;
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomHeader(
          title: "Product",
          // svgName: "new-cart.svg",
          // route: "/cart",
          isPop: true,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              SearchForm(
                controller: searchController,
                callback: () {
                  getData();
                },
              ),
              SpacerHeight(h: 20),
              (isLoad)
                  ? Center(child: CupertinoActivityIndicator())
                  : GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: (itemWidth / 250),
                      children: List.generate(product.length, (index) {
                        p.Product prod = product[index];
                        return _sliderBox(
                            prod.product_image, prod.name, prod.price, prod.id);
                      }),
                    ),
              SpacerHeight(h: 20),
            ],
          ),
        ),
      ),
    );
  }

  productWidget(String image, String name, int price, int id) {
    return GestureDetector(
      onTap: (() => GoRouter.of(context).push("/product-detail/$id")),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width / 2,
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: CustomFont.medium12,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(rupiah(price), style: CustomFont.bold12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sliderBox(String image, String name, int price, int id) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return Container(
      width: itemWidth,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (() => GoRouter.of(context).push("/product-detail/$id")),
            child: Container(
              width: itemWidth,
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
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      name,
                      style: CustomFont(
                              CustomColor.blackColor, 14, FontWeight.w700)
                          .font,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SpacerHeight(h: 5),
                  Text(
                    rupiah(price),
                    style:
                        CustomFont(CustomColor.brownColor, 14, FontWeight.w400)
                            .font,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          //   child: InkWell(
          //     onTap: () {
          //       cart.addToCart(
          //           productId: id,
          //           unitPrice: price,
          //           productName: name,
          //           productDetailsObject: image);
          //     },
          //     child: Container(
          //       height: 30,
          //       decoration: BoxDecoration(
          //         color: CustomColor.brownColor,
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Center(
          //         child: Text(
          //           "Add to Cart",
          //           style:
          //               CustomFont(CustomColor.whiteColor, 10, FontWeight.w600)
          //                   .font,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
