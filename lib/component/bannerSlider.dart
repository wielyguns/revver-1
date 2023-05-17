// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/home.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/banner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeBanner extends StatefulWidget {
  HomeBanner({Key key}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  Timer _timer;
  List list;
  int i = 0;
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true, initialPage: 0);

  getBanner() async {
    await getHomeBanner().then((val) {
      setState(() {
        list = val;
      });
      _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
        if (i < list.length) {
          i++;
        } else {
          i = 0;
        }
        controller.animateToPage(
          i,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    });
  }

  @override
  void initState() {
    getBanner();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (list != null) {
      if (list.length >= 5) {
        i = 5;
      } else {
        i = list.length;
      }
      list.sort((min, max) => min.order.compareTo(max.order));
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
