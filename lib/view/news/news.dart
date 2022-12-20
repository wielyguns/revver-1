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
          : ListView.separated(
              itemCount: news.length,
              itemBuilder: (context, index) {
                n.News nws = news[index];
                return Column(
                  children: [
                    (index == 0) ? SpacerHeight(h: 20) : SizedBox(),
                    newsWidget(
                      nws.image ??=
                          "https://wallpaperaccess.com/full/733834.png",
                      nws.title ??= "...",
                      nws.created_at ??= "...",
                      nws.id ??= 0,
                    ),
                    (index == news.length - 1)
                        ? SpacerHeight(h: 20)
                        : SizedBox(),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Divider(
                    thickness: 2,
                    color: CustomColor.brownColor.withOpacity(0.5),
                  ),
                );
              },
            ),
    );
  }

  newsWidget(String image, String title, String created_at, int id) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: (() => GoRouter.of(context).push("/news-detail/$id")),
        child: Container(
          width: CustomScreen(context).width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: image ??=
                      "https://wallpaperaccess.com/full/733834.png",
                  fit: BoxFit.cover,
                  height: 120,
                  width: 120,
                ),
              ),
              SpacerWidth(w: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: CustomColor.brownColor,
                                size: 12,
                              ),
                              SpacerWidth(w: 5),
                              Text(created_at,
                                  style: CustomFont(
                                          CustomColor.brownColor, 9, null)
                                      .font),
                            ],
                          ),
                          SpacerHeight(h: 5),
                          Text(
                            title ??= "...",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: CustomFont.bold16,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text("Read More", style: CustomFont.bold10),
                              Icon(
                                Icons.arrow_right_alt,
                                color: CustomColor.oldGreyColor,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
