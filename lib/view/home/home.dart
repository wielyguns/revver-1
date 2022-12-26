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

  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  String name;
  List product;
  List banner;
  List news;

  getDataHeader() async {
    await getHomeHeader().then((val) {
      setState(() {
        name = val['data']['name'];
        // print(val);
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
    if (!GoRouter.of(context).location.contains("xxx")) {
      setState(() {});
      GoRouter.of(context).removeListener(callback);
    }
  }

  @override
  void initState() {
    super.initState();
    getDataHeader();
    getNewsList();
    getProductList();
    getBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/img/revver-horizontal.png",
          width: CustomScreen(context).width / 2.5,
        ),
        actions: [
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
                        "assets/svg/cart-shopping-solid.svg",
                        height: 20,
                      ),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   child: Container(
                    //     padding: const EdgeInsets.all(1),
                    //     decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     constraints: const BoxConstraints(
                    //       minWidth: 15,
                    //       minHeight: 15,
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         cart.getCartItemCount().toString(),
                    //         style: CustomFont.badge,
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   ),
                    // )
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
                      ),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   child: Container(
                    //     padding: const EdgeInsets.all(1),
                    //     decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     constraints: const BoxConstraints(
                    //       minWidth: 15,
                    //       minHeight: 15,
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         '99',
                    //         style: CustomFont.badge,
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   ),
                    // )
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
                  child: SvgPicture.asset(
                    "assets/svg/user-solid.svg",
                    height: 20,
                  ),
                ),
              ),
              SpacerWidth(w: 20),
            ],
          ),
        ],
        backgroundColor: CustomColor.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpacerHeight(h: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: WelcomeHeader(name: name ??= "..."),
              ),
              SpacerHeight(h: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: HomeBanner(list: banner),
              ),
              SpacerHeight(h: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
      ),
    );
  }
}
