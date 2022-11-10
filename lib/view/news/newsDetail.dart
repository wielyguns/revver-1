import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({Key key}) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "News Detail",
        isPop: true,
      ),
    );
  }
}
