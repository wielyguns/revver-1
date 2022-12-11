// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/news.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  String title;
  String image;
  String content;
  String url;
  int status;

  bool isLoad = true;

  getData() async {
    await getNewsDetail(widget.id).then((val) {
      setState(() {
        title = val['data']['title'];
        image = val['data']['image'];
        content = val['data']['content'];
        url = val['data']['url'];
        isLoad = false;
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
        title: title ??= "",
        isPop: true,
        offMiddleLogo: true,
        image: image ??= "https://wallpaperaccess.com/full/733834.png",
        height: 300,
      ),
      body: (isLoad)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SpacerHeight(h: 20),
                  // SizedBox(
                  //   width: CustomScreen(context).width,
                  //   height: 200,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.all(Radius.circular(32)),
                  //     child: CachedNetworkImage(
                  //       imageUrl: image ??=
                  //           "https://wallpaperaccess.com/full/733834.png",
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  // SpacerHeight(h: 20),
                  // Text(
                  //   title ??= "...",
                  //   style: CustomFont.regular24,
                  // ),
                  SpacerHeight(h: 20),
                  Html(data: content ??= "..."),
                  SpacerHeight(h: 20),
                ],
              ),
            ),
    );
  }
}
