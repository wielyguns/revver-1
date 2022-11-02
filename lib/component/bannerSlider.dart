import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/test.dart';
import 'package:revver/globals.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class HomeBanner extends StatelessWidget {
  HomeBanner({Key key}) : super(key: key);
  int i = 10;
  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: SizedBox(
            width: CustomScreen(context).width,
            height: CustomScreen(context).width / 2.5,
            child: PageView.builder(
              controller: controller,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: i,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    _sliderWidget(context,
                        "https://wallpaperaccess.com/full/733834.png", "Slug"),
                  ],
                );
              },
            ),
          ),
        ),
        SpacerHeight(h: 20),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: SmoothPageIndicator(
                  controller: controller,
                  count: 10,
                  effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: CustomColor.greyColor,
                      activeDotColor: CustomColor.goldColor),
                  onDotClicked: (index) {}),
            ),
          ),
        ),
      ],
    );
  }

  _sliderWidget(BuildContext context, String gambar, String slug) {
    return InkWell(
      child: Container(
          width: CustomScreen(context).width - 40,
          height: CustomScreen(context).width / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Stack(
            children: [
              SizedBox(
                width: CustomScreen(context).width - 40,
                height: CustomScreen(context).width / 2.5,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: gambar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          )),
      onTap: () {
        test(context);
      },
    );
  }
}
