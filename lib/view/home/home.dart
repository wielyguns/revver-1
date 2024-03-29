import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/bannerSlider.dart';
import 'package:revver/component/menu.dart';
import 'package:revver/component/newsSlider.dart';
import 'package:revver/component/productSlider.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/component/welcomeHeader.dart';
import 'package:revver/controller/home.dart';
import 'package:revver/globals.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cartCounter = "99";
  String notificationCounter = "99";
  var cart = FlutterCart();

  ScrollController scrollController = ScrollController(initialScrollOffset: 1);
  String name;
  String avatar;
  List product;
  List news;

  getDataHeader() async {
    await getHomeHeader().then((val) {
      setState(() {
        name = val['data']['name'];
        avatar = val['data']['avatar'];
        // print(val);
      });
    });
  }

  getNewsList() async {
    await getHomeNews().then((val) {
      setState(() {
        news = val;
        // print(val);
      });
    });
  }

  getProductList() async {
    await getHomeProduct().then((val) {
      setState(() {
        product = val;
      });
    });
  }

  callback() {
    if (!mounted) return;
    if (!GoRouter.of(context).location.contains("xxx")) {
      setState(() {});
      GoRouter.of(context).removeListener(callback);
    }
  }

  @override
  void initState() {
    getDataHeader();
    getNewsList();
    getProductList();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    getDataHeader();
    getNewsList();
    getProductList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double w = CustomScreen(context).width;
    double x = w - 70;
    double y = x / 5;
    double z = y * 2;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: CustomScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Color(0xFF212121),
              elevation: 0,
              expandedHeight: z + 185,
              stretch: true,
              pinned: true,
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: headerWidget(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.fadeTitle,
                  StretchMode.zoomBackground,
                ],
                background: Container(
                  padding: EdgeInsets.all(35),
                  width: MediaQuery.of(context).size.width,
                  height: z + 185,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/revver-bg-1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SpacerHeight(h: 40),
                      SpacerHeight(h: 20),
                      WelcomeHeader(name: name ??= "..."),
                      SpacerHeight(h: 20),
                      HomeBanner(),
                      SpacerHeight(h: 20),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpacerHeight(h: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: HomeMenu(),
                  ),
                  SpacerHeight(h: 40),
                  ProductSlider(
                    product: product,
                    callback: (x) {
                      setState(() {});
                    },
                    callbackPop: () => callback(),
                  ),
                  SpacerHeight(h: 40),
                  NewsSlider(news: news),
                  SpacerHeight(h: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/img/revver-white.png",
          width: CustomScreen(context).width / 2.5,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push("/cart");
                GoRouter.of(context).addListener(callback());
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      "assets/svg/new-cart.svg",
                      height: 20,
                      color: CustomColor.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SpacerWidth(w: 5),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push("/notification");
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SvgPicture.asset(
                      "assets/svg/bell-solid.svg",
                      height: 20,
                      color: CustomColor.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SpacerWidth(w: 5),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push("/homepage/3");
              },
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                          image: NetworkImage(avatar ??=
                              "https://wallpaperaccess.com/full/733834.png"),
                          fit: BoxFit.cover),
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
