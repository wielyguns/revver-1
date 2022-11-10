import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class News extends StatefulWidget {
  const News({Key key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
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
    return GestureDetector(
      onTap: (() => GoRouter.of(context).push("/news-detail")),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: CustomColor.oldGreyColor)),
        child: Row(
          children: [
            SizedBox(
              width: 150,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: "https://wallpaperaccess.com/full/733834.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                      style: CustomFont.regular12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("data", style: CustomFont.newsAuthor),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
