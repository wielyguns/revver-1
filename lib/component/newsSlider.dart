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
        child: (news == null)
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  News nws = news[index];
                  return Row(
                    children: [
                      _sliderBox(
                        context,
                        nws.image ??=
                            "https://wallpaperaccess.com/full/733834.png",
                        nws.title ??= "...",
                        nws.created_at ??= "...",
                        nws.id ??= 0,
                      ),
                      (3 - 1 == index)
                          ? SizedBox(width: 0)
                          : SizedBox(width: 15),
                    ],
                  );
                },
              ),
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
          // border: Border.all(color: CustomColor.oldGreyColor),
        ),
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
                  imageUrl: image,
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
                    title,
                    style: CustomFont.bold12,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SpacerHeight(h: 5),
                  Row(
                    children: [
                      Text(date, style: CustomFont.newsDate),
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
