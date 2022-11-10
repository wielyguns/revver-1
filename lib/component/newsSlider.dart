import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/test.dart';
import 'package:revver/globals.dart';

// ignore: must_be_immutable
class NewsSlider extends StatelessWidget {
  NewsSlider({Key key}) : super(key: key);
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
          "News & Updates",
          style: CustomFont.widgetTitle,
        ),
        GestureDetector(
          child: Text(
            "View All",
            style: CustomFont.link,
          ),
          onTap: () {
            GoRouter.of(context).push("/news");
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
        height: 220,
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
    return InkWell(
      onTap: () {
        test(context);
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: CustomColor.oldGreyColor)),
        child: Column(
          children: [
            SizedBox(
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpacerHeight(h: 5),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                    style: CustomFont.bold12,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SpacerHeight(h: 5),
                  Row(
                    children: [
                      Text("by ", style: CustomFont.newsDate),
                      Text("Author", style: CustomFont.newsAuthor),
                      Text(" , ", style: CustomFont.newsDate),
                      Text("11-10-2022", style: CustomFont.newsDate),
                    ],
                  ),
                  SpacerHeight(h: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
