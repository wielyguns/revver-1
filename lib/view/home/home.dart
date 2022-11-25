import 'package:flutter/material.dart';
import 'package:revver/component/bannerSlider.dart';
import 'package:revver/component/menu.dart';
import 'package:revver/component/newsSlider.dart';
import 'package:revver/component/productSlider.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/component/welcomeHeader.dart';
import 'package:revver/controller/home.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/product.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  String name;
  List product;
  List banner;

  getDataHeader() async {
    await getHomeHeader().then((val) {
      setState(() {
        name = val['data']['name'];
        print(val);
      });
    });
  }

  getBanner() async {
    await getHomeBanner().then((val) {
      setState(() {
        banner = val;
      });
    });
  }

  getNewsList() async {
    await getHomeNews().then((val) {
      setState(() {
        print(val);
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

  @override
  void initState() {
    super.initState();
    getDataHeader();
    // getNewsList();
    getProductList();
    getBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Revver",
          style: CustomFont.subheading,
        ),
        backgroundColor: CustomColor.whiteColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              WelcomeHeader(name: name ??= "..."),
              SpacerHeight(h: 20),
              HomeBanner(list: banner),
              SpacerHeight(h: 40),
              HomeMenu(),
              SpacerHeight(h: 40),
              ProductSlider(product: product),
              SpacerHeight(h: 40),
              NewsSlider(),
              SpacerHeight(h: 20),
            ],
          ),
        ),
      ),
    );
  }
}
