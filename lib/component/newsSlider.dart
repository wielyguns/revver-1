import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/news.dart';

// ignore: must_be_immutable
class NewsSlider extends StatelessWidget {
  NewsSlider({Key key, this.news}) : super(key: key);
  List news;

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
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "News & Updates",
            style: CustomFont(CustomColor.brownColor, 16, FontWeight.bold).font,
          ),
          GestureDetector(
            child: Text(
              "View All",
              style: CustomFont(CustomColor.blackColor, 12, null).font,
            ),
            onTap: () {
              GoRouter.of(context).push("/news");
            },
          ),
        ],
      ),
    );
  }

  _sliderWidget(BuildContext context) {
    return SizedBox(
      width: CustomScreen(context).width,
      height: 258,
      child: (news == null)
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              clipBehavior: Clip.none,
              itemBuilder: (BuildContext context, int index) {
                News nws = news[index];
                return Row(
                  children: [
                    (0 == index) ? SizedBox(width: 20) : SizedBox(width: 0),
                    _sliderBox(
                      context,
                      nws.image ??=
                          "https://wallpaperaccess.com/full/733834.png",
                      nws.title ??= "...",
                      nws.created_at ??= "...",
                      nws.id ??= 0,
                    ),
                    SizedBox(width: 20),
                  ],
                );
              },
            ),
    );
  }

  _sliderBox(
      BuildContext context, String image, String title, String date, int id) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push("/news-detail/$id"),
      child: Container(
        width: 200,
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
            Container(
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SpacerHeight(h: 5),
                    Row(
                      children: [
                        Text(date, style: CustomFont.newsDate),
                      ],
                    ),
                    SpacerHeight(h: 5),
                    Text(
                      // title,
                      "AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA AAAAA",
                      style: CustomFont.bold12,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SpacerHeight(h: 10),
                  ],
                ),
              ),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: CustomColor.brownColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  "Read More",
                  style: CustomFont(CustomColor.whiteColor, 12, null).font,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
