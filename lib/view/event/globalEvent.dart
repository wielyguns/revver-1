import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';

// ignore: must_be_immutable
class GlobalEvent extends StatefulWidget {
  GlobalEvent({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<GlobalEvent> createState() => _GlobalEventState();
}

class _GlobalEventState extends State<GlobalEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        isPop: true,
        title: "Global Event",
      ),
      body: Column(
        children: [
          SizedBox(
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: "https://wallpaperaccess.com/full/733834.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SpacerHeight(h: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          )
        ],
      ),
    );
  }
}
