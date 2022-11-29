// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/news.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/news.dart' as n;

class News extends StatefulWidget {
  const News({Key key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  List news;

  getData() async {
    await getNews().then((val) {
      setState(() {
        news = val;
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
    return Scaffold(
      appBar: CustomHeader(
        title: "News & Updates",
        isPop: true,
      ),
      body: (news == null)
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ListView.separated(
                separatorBuilder: ((context, index) {
                  return SpacerHeight(h: 10);
                }),
                itemCount: news.length,
                itemBuilder: (context, index) {
                  n.News nws = news[index];
                  return newsWidget(
                    nws.image ??= "https://wallpaperaccess.com/full/733834.png",
                    nws.title ??= "...",
                    nws.created_at ??= "...",
                    nws.id ??= 0,
                  );
                },
              ),
            ),
    );
  }

  newsWidget(String image, String title, String created_at, int id) {
    return GestureDetector(
      onTap: (() => GoRouter.of(context).push("/news-detail/$id")),
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
                  imageUrl: image,
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
                      title,
                      style: CustomFont.bold12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(created_at, style: CustomFont.newsAuthor),
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
