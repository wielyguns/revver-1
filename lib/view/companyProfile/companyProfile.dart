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
                    listWidget('Our Contact', ourContact(),
                        "assets/svg/compro-call.svg"),
                    listWidget(
                        'Legality', legality(), "assets/svg/compro-libra.svg"),
                    goToProduct('Our Product', "assets/svg/compro-cart.svg"),
                    listWidget('Ethical Code', ethicalCode(),
                        "assets/svg/compro-clipboard.svg"),
                    listWidget('Distribution Flow', distributionFlow(),
                        "assets/svg/compro-puzzle.svg"),
                    listWidget(
                        'Syariah Business Strategy',
                        syariahBusinessStrategy(),
                        "assets/svg/compro-chart.svg"),
                    listWidget('Profile of Management', profileOfManagement(),
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
                          Text(
                              "Menjadikan PT. Revival Network Internasional ( RNI ) sebagai perusahaan dari Indonesia yang mendunia dalam bidang Multi Level Marketing. Dan menjadikan usaha yang bisa mensejahterakan masyarakat dan solusi dalam penghidupan yang lebih baik."),
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
                          Text(
                              "1. Membangun Management yang profesional.\n2. Memberikan Produk produk terbaik yang berkualitas , Unik dan Inovatif.\n3. Memberikan Penghasilan dan Karier jangka panjang bagi Anggota nya.\n4. Memberikan pelatihan Pengembangan diri, pelatihan Online dan pelatihan marketing untuk anggota nya.\n5. Memberikan fasilitas fasilitas pendukung, terutama yang berhubungan dengan dunia digital sehubungan dengan berkembangnya arah era kedepan."),
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

  ourContact() {
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
                            "Our Contact",
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
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColor.brownColor,
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: CustomColor.whiteColor,
                        ),
                      ),
                      SpacerWidth(w: 10),
                      Expanded(
                        child: Column(
                          children: [
                            SpacerHeight(h: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Address",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w600)
                                      .font,
                                ),
                                Text(
                                  "See Maps",
                                  style: CustomFont(CustomColor.brownColor, 13,
                                          FontWeight.w400)
                                      .font,
                                ),
                              ],
                            ),
                            SpacerHeight(h: 15),
                            Row(
                              children: [
                                Text(
                                  "Jl. Letjen S. Parman No. 106\nRT 05/RW 03, Tj. Duren Sel.\nKec. Grogol Petamburan,\nKota Jakarta Barat\nDaerah Khusus Ibukota Jakarta",
                                  style: CustomFont(CustomColor.oldGreyColor,
                                          13, FontWeight.w400)
                                      .font,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SpacerHeight(h: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColor.brownColor,
                        ),
                        child: Icon(
                          Icons.call,
                          color: CustomColor.whiteColor,
                        ),
                      ),
                      SpacerWidth(w: 10),
                      Expanded(
                        child: Column(
                          children: [
                            SpacerHeight(h: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Phone",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w600)
                                      .font,
                                ),
                                Text(
                                  "Call Now",
                                  style: CustomFont(CustomColor.brownColor, 13,
                                          FontWeight.w400)
                                      .font,
                                ),
                              ],
                            ),
                            SpacerHeight(h: 15),
                            Row(
                              children: [
                                Text(
                                  "+62 878 3777 7788",
                                  style: CustomFont(CustomColor.oldGreyColor,
                                          13, FontWeight.w400)
                                      .font,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SpacerHeight(h: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColor.brownColor,
                        ),
                        child: Icon(
                          Icons.email,
                          color: CustomColor.whiteColor,
                        ),
                      ),
                      SpacerWidth(w: 10),
                      Expanded(
                        child: Column(
                          children: [
                            SpacerHeight(h: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w600)
                                      .font,
                                ),
                                Text(
                                  "Send email",
                                  style: CustomFont(CustomColor.brownColor, 13,
                                          FontWeight.w400)
                                      .font,
                                ),
                              ],
                            ),
                            SpacerHeight(h: 15),
                            Row(
                              children: [
                                Text(
                                  "revival.management@gmail.com",
                                  style: CustomFont(CustomColor.oldGreyColor,
                                          13, FontWeight.w400)
                                      .font,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SpacerHeight(h: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColor.brownColor,
                        ),
                        child: Icon(
                          Icons.web_rounded,
                          color: CustomColor.whiteColor,
                        ),
                      ),
                      SpacerWidth(w: 10),
                      Expanded(
                        child: Column(
                          children: [
                            SpacerHeight(h: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Website",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w600)
                                      .font,
                                ),
                                Text(
                                  "Visit",
                                  style: CustomFont(CustomColor.brownColor, 13,
                                          FontWeight.w400)
                                      .font,
                                ),
                              ],
                            ),
                            SpacerHeight(h: 15),
                            Row(
                              children: [
                                Text(
                                  "www.revivalnetwork.co.id",
                                  style: CustomFont(CustomColor.oldGreyColor,
                                          13, FontWeight.w400)
                                      .font,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  legality() {
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
                            "Legality",
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
              child: Column(
                children: [Text("Legality")],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ethicalCode() {
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
                            "Ethical Code",
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
              child: Column(
                children: [Text("Ethical Code")],
              ),
            ),
          ],
        ),
      ),
    );
  }

  distributionFlow() {
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
                            "Distribution Flow",
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
              child: Column(
                children: [Text("Distribution Flow")],
              ),
            ),
          ],
        ),
      ),
    );
  }

  syariahBusinessStrategy() {
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
                            "Syariah Business Strategy",
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
              child: Column(
                children: [Text("Syariah Business Strategy")],
              ),
            ),
          ],
        ),
      ),
    );
  }

  profileOfManagement() {
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
                            "Profile of Management",
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
              child: Column(
                children: [Text("Profile of Management")],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
