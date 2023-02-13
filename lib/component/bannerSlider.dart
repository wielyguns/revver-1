import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/banner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class HomeBanner extends StatelessWidget {
  HomeBanner({Key key, this.list}) : super(key: key);
  List list;
  int i = 3;
  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    if (list != null) {
      if (list.length >= 5) {
        i = 5;
      } else {
        i = list.length;
      }
    }
    double w = CustomScreen(context).width;
    double x = w - 70;
    double y = x / 5;
    double v = y * 5;
    double z = y * 2;
    return Stack(
      children: [
        (list == null)
            ? Container(
                width: v,
                height: z,
                decoration: BoxDecoration(
                  color: CustomColor.backgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 13,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: CupertinoActivityIndicator(),
              )
            : Container(
                decoration: BoxDecoration(
                  color: CustomColor.backgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 13,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: SizedBox(
                    width: v,
                    height: z,
                    child: PageView.builder(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      itemCount: i,
                      itemBuilder: (BuildContext context, int index) {
                        BannerModel banner = list[index];
                        return Row(
                          children: [_sliderWidget(context, banner.image)],
                        );
                      },
                    ),
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
                  count: i,
                  effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      dotColor: CustomColor.greyColor,
                      activeDotColor: CustomColor.brownColor),
                  onDotClicked: (index) {}),
            ),
          ),
        ),
      ],
    );
  }

  _sliderWidget(BuildContext context, String gambar) {
    double w = CustomScreen(context).width;
    double x = w - 70;
    double y = x / 5;
    double v = y * 5;
    double z = y * 2;
    return Container(
      width: v,
      height: z,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: v,
            height: z,
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: gambar,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
