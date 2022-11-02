import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/test.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class ProductSlider extends StatelessWidget {
  ProductSlider({Key key}) : super(key: key);
  int i = 3;

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Product",
          style: CustomFont.widgetTitle,
        ),
        GestureDetector(
          child: Text(
            "View All",
            style: CustomFont.link,
          ),
          onTap: () {
            test(context);
          },
        ),
      ],
    );
  }

  _sliderWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: SizedBox(
        width: CustomScreen(context).width,
        height: 251,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: i,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                _sliderBox(
                    context,
                    "https://wallpaperaccess.com/full/733834.png",
                    "data",
                    "data",
                    "data"),
                (i - 1 == index) ? SizedBox(width: 0) : SizedBox(width: 15),
              ],
            );
          },
        ),
      ),
    );
  }

  _sliderBox(BuildContext context, String gambar, String judul, String slug,
      String kategori) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: CustomColor.oldGreyColor)),
      child: Column(
        children: [
          InkWell(
            child: SizedBox(
              width: 200,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: gambar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () {
              test(context);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpacerHeight(h: 5),
                Text("Product", style: CustomFont.bold12),
                SpacerHeight(h: 5),
                Text("Price", style: CustomFont.regular12),
                SpacerHeight(h: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: AddToCartButton(
                    func: () {
                      test(context);
                    },
                  ),
                ),
                SpacerHeight(h: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
