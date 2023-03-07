import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
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
  var cart = FlutterCart();
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomHeader(
  //       title: "E-Learning",
  //       isPop: true,
  //     ),
  //     body: (isLoad)
  //         ? Center(child: CupertinoActivityIndicator())
  //         : SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 listWidget(),
  //               ],
  //             ),
  //           ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomHeader(
          title: "E-Learning",
          svgName: "new-cart.svg",
          route: "/cart",
          isPop: true,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              // SearchForm(
              //   controller: searchController,
              //   callback: () {
              //     getData();
              //   },
              // ),
              // SpacerHeight(h: 20),
              (isLoad)
                  ? Center(child: CupertinoActivityIndicator())
                  : GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: (itemWidth / 300),
                      children: List.generate(eLearning.length, (index) {
                        e.ELearning prod = eLearning[index];
                        return _sliderBox(
                            prod.thumbnail, prod.name, prod.price, prod.id);
                      }),
                    ),
              SpacerHeight(h: 20),
            ],
          ),
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
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
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
          padding: EdgeInsets.symmetric(horizontal: 35),
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

  _sliderBox(String image, String name, int price, int id) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return Container(
      width: itemWidth,
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
          GestureDetector(
            onTap: (() => GoRouter.of(context).push('/e-learning-detail/$id')),
            child: Container(
              width: itemWidth,
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
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      name,
                      style: CustomFont(
                              CustomColor.blackColor, 14, FontWeight.w700)
                          .font,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SpacerHeight(h: 5),
                  Text(
                    rupiah(price),
                    style:
                        CustomFont(CustomColor.brownColor, 14, FontWeight.w400)
                            .font,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: InkWell(
              onTap: () {
                cart.addToCart(
                    productId: id,
                    unitPrice: price,
                    productName: name,
                    productDetailsObject: image);
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: CustomColor.brownColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Add to Cart",
                    style:
                        CustomFont(CustomColor.whiteColor, 10, FontWeight.w600)
                            .font,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
