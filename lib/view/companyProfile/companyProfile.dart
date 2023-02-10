import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({Key key}) : super(key: key);
  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/revver-bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              children: [
                SpacerHeight(h: 65),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Image.asset('assets/img/revver-white.png'),
                ),
                SpacerHeight(h: 20),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    listWidget('Vision & Mission', visiMisi(),
                        "assets/svg/compro-arrow.svg"),
                    listWidget('Our Contact', visiMisi(),
                        "assets/svg/compro-call.svg"),
                    listWidget(
                        'Legality', visiMisi(), "assets/svg/compro-libra.svg"),
                    goToProduct('Our Product', "assets/svg/compro-cart.svg"),
                    listWidget('Ethical Code', visiMisi(),
                        "assets/svg/compro-clipboard.svg"),
                    listWidget('Distribution Flow', visiMisi(),
                        "assets/svg/compro-puzzle.svg"),
                    listWidget('Syariah Business Strategy', visiMisi(),
                        "assets/svg/compro-chart.svg"),
                    listWidget('Profile of Management', visiMisi(),
                        "assets/svg/compro-tree-man.svg"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  goToProduct(String name, svg) {
    return GestureDetector(
      onTap: (() {
        GoRouter.of(context).pop();
        GoRouter.of(context).push('/product');
      }),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 13,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svg,
              width: 40,
            ),
            SpacerHeight(h: 20),
            Text(
              name,
              style:
                  CustomFont(CustomColor.blackColor, 12, FontWeight.w600).font,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  listWidget(String name, wd, svg) {
    return GestureDetector(
      onTap: (() {
        return showGeneralDialog(
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(scale: a1.value, child: wd);
            },
            barrierColor: Colors.black.withOpacity(0.7),
            transitionDuration: Duration(milliseconds: 300),
            context: context,
            barrierDismissible: true,
            barrierLabel: '',
            pageBuilder: (context, animation1, animation2) {
              return;
            });
      }),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 13,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svg,
              width: 40,
            ),
            SpacerHeight(h: 20),
            Text(
              name,
              style:
                  CustomFont(CustomColor.blackColor, 12, FontWeight.w600).font,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  visiMisi() {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 220,
                  width: CustomScreen(context).width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/img/revver-bg.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: kToolbarHeight),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            "Vision & Mission",
                            style: CustomFont(
                                    CustomColor.whiteColor, 32, FontWeight.bold)
                                .font,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.only(top: kToolbarHeight, right: 20),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SpacerHeight(h: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: ExpandableNotifier(
                child: Column(
                  children: [
                    Expandable(
                      collapsed: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Vision",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w400)
                                      .font),
                              ExpandableButton(
                                child: RotatedBox(
                                  quarterTurns: 2,
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: CustomColor.brownColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            color: CustomColor.brownColor.withOpacity(0.5),
                          )
                        ],
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Vision",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w400)
                                      .font),
                              ExpandableButton(
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: CustomColor.brownColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            color: CustomColor.brownColor.withOpacity(0.5),
                          ),
                          Text("..."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SpacerHeight(h: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: ExpandableNotifier(
                child: Column(
                  children: [
                    Expandable(
                      collapsed: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mission",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w400)
                                      .font),
                              ExpandableButton(
                                child: RotatedBox(
                                  quarterTurns: 2,
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: CustomColor.brownColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            color: CustomColor.brownColor.withOpacity(0.5),
                          )
                        ],
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mission",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w400)
                                      .font),
                              ExpandableButton(
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: CustomColor.brownColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            color: CustomColor.brownColor.withOpacity(0.5),
                          ),
                          Text("..."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
