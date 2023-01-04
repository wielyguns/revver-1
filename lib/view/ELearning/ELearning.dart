import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/ELearning.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/ELearning.dart' as e;

class ELearning extends StatefulWidget {
  const ELearning({Key key}) : super(key: key);

  @override
  State<ELearning> createState() => _ELearningState();
}

class _ELearningState extends State<ELearning> {
  bool isLoad = true;
  List<e.ELearning> eLearning;

  getData() async {
    if (!mounted) return;
    await getELearning().then((val) {
      setState(() {
        eLearning = val;
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "E-Learning",
        isPop: true,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  listWidget(),
                ],
              ),
            ),
    );
  }

  listWidget() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: eLearning.length,
      itemBuilder: (context, index) {
        e.ELearning list = eLearning[index];
        return Column(
          children: [
            (index == 0) ? SpacerHeight(h: 20) : SizedBox(),
            listItem(list.thumbnail, list.name, list.id),
            // SpacerHeight(h: 20),
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
    );
  }

  listItem(String image, String name, int id) {
    return IntrinsicHeight(
      child: GestureDetector(
        onTap: (() {
          GoRouter.of(context).push('/e-learning-detail/$id');
        }),
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
                      Text(
                        name ??= "...",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: CustomFont.bold16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Read More", style: CustomFont.bold10),
                          Icon(
                            Icons.arrow_right_alt,
                            color: CustomColor.oldGreyColor,
                          ),
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
