import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/product.dart';

// ignore: must_be_immutable
class ProductSlider extends StatelessWidget {
  ProductSlider({Key key, this.product, this.callback, this.callbackPop})
      : super(key: key);
  List product;
  var cart = FlutterCart();
  Function(String x) callback;
  Function callbackPop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _titleWidget(context),
        SpacerHeight(h: 10),
        _sliderWidget(context),
      ],
    );
  }

  _titleWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Product",
            style: CustomFont(CustomColor.brownColor, 20, FontWeight.bold).font,
          ),
          GestureDetector(
            child: Text(
              "Lihat Semua",
              style: CustomFont(CustomColor.blackColor, 14, null).font,
            ),
            onTap: () {
              GoRouter.of(context).push("/product");
              GoRouter.of(context).addListener(callbackPop);
            },
          ),
        ],
      ),
    );
  }

  _sliderWidget(BuildContext context) {
    return SizedBox(
      width: CustomScreen(context).width,
      height: 210,
      child: (product == null)
          ? Center(child: CupertinoActivityIndicator())
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              clipBehavior: Clip.none,
              itemBuilder: (BuildContext context, int index) {
                Product prod = product[index];
                return Row(
                  children: [
                    (0 == index) ? SizedBox(width: 35) : SizedBox(width: 0),
                    _sliderBox(
                      context,
                      prod.product_image ??=
                          "https://wallpaperaccess.com/full/733834.png",
                      prod.name ??= "...",
                      prod.price ??= 0,
                      prod.id ??= 0,
                    ),
                    SizedBox(width: 20),
                  ],
                );
              },
            ),
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
                  // SpacerWidth(w: 20),
                  // InkWell(
                  //   onTap: () {
                  //     cart.addToCart(
                  //         productId: id,
                  //         unitPrice: price,
                  //         productName: name,
                  //         productDetailsObject: gambar);
                  //     callback("x");
                  //   },
                  //   child: Container(
                  //     height: 30,
                  //     width: 30,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //       color: CustomColor.brownColor,
                  //     ),
                  //     child: Icon(Icons.add, color: CustomColor.whiteColor),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
