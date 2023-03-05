import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
                    listWidget('Visi & Misi', visiMisi(),
                        "assets/svg/compro-arrow.svg"),
                    listWidget('Kontak Kami', ourContact(),
                        "assets/svg/compro-call.svg"),
                    listWidget(
                        'Legalitas', legality(), "assets/svg/compro-libra.svg"),
                    goToProduct('Produk Kami', "assets/svg/compro-cart.svg"),
                    listWidget('Kode Etik', ethicalCode(),
                        "assets/svg/compro-clipboard.svg"),
                    listWidget('Alur Distribusi', distributionFlow(),
                        "assets/svg/compro-puzzle.svg"),
                    // listWidget(
                    //     'Syariah Business Strategy',
                    //     syariahBusinessStrategy(),
                    //     "assets/svg/compro-chart.svg"),
                    listWidget('Profil Manajemen', profileOfManagement(),
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
                            "Visi & Misi",
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
                              Text("Visi",
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
                              Text("Visi",
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
                              Text("Misi",
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
                              Text("Misi",
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
                            "Kontak Kami",
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
                                  "Alamat",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w600)
                                      .font,
                                ),
                                Text(
                                  "Lihat Map",
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
                                  "Telepon",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w600)
                                      .font,
                                ),
                                Text(
                                  "Hubungi Sekarang",
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
                                  "Kirim Email",
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
                                  "Situs",
                                  style: CustomFont(CustomColor.blackColor, 14,
                                          FontWeight.w600)
                                      .font,
                                ),
                                Text(
                                  "Kunjungi",
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
                            "Legalitas",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nomor Induk Berusaha (NIB)",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Nomor : 3006220068772"),
                  Text("Perusahaan : PT REVIVAL NETWORK INTERNASIONAL"),
                  Text(""),
                  Text("Tanda Daftar Penyelenggara Sistem Elektronik (TDPSE)",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Nomor : 007796.01/DJAI.PSE/09/2022"),
                  Text("Tanggal Terbit : 19-09-2022"),
                  Text("Nama Penyelenggara : Revival Network Internasional"),
                  Text(""),
                  Text(
                      "Keputusan Menteri Hukum dan Hak Asasi Manusia Republik Indonesia",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Nomor : AHU-4022.062731.107097"),
                  Text("Tanggal : 27 Juni 2022l"),
                  Text("Perusahaan : PT REVIVAL NETWORK INTERNASIONAL"),
                  Text(""),
                  Text("Surat Izin Usaha Perdagangan (SIUP)",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Nomor : 30062200687720001"),
                  Text("Perusahaan : PT REVIVAL NETWORK INTERNASIONAL"),
                  Text(""),
                  Text("Tanda Keanggotaan APLI",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Nomor : 0237/09/22"),
                  Text("Perusahaan : PT REVIVAL NETWORK INTERNASIONAL"),
                ],
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
      body: Column(
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
                          "Kode Etik",
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
          Expanded(
            child: SfPdfViewer.asset(
              "assets/pdf/KODE_ETIK_REVVER.pdf",
              scrollDirection: PdfScrollDirection.horizontal,
              pageLayoutMode: PdfPageLayoutMode.single,
            ),
          ),
        ],
      ),
    );
  }

  distributionFlow() {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: Column(
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
                          "Alur Distribusi",
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                "assets/img/ALUR-DISTRIBUSI-BARANG.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
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
                            "Profil Manajemen",
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 35),
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/img/profile-management-bg.png"),
                  fit: BoxFit.cover,
                ),
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/img/PAK-FILI-CROP.jpg"),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fili",
                            style: CustomFont(
                                    CustomColor.brownColor, 15, FontWeight.w600)
                                .font,
                          ),
                          Text(
                            "Muttaqien",
                            style: CustomFont(
                                    CustomColor.blackColor, 15, FontWeight.w600)
                                .font,
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: CustomColor.brownColor,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Text(
                              "CEO",
                              style: CustomFont(CustomColor.whiteColor, 10,
                                      FontWeight.w600)
                                  .font,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                      "Fili Muttaqien lahir di Palembang pada tanggal 15 April 1982. Sejak tahun 2003 dimana Fili masih menjadi Mahasiswa, dia sudah mulai aktif berbisnis Network Marketing di Bandung. Selama 20 tahun dia fokus merintis dan menekuni Network Marketing di beberapa perusahaan bertaraf Internasional. Hal ini membuat Fili banyak belajar  untuk berproses dan menambah pengalaman dalam meraih peringkat tinggi maupun reward.  Saat ini Fili berusia 41 tahun dan menjabat menjadi CEO di PT. Revival Network Internasional ( REVVER ). Dia bertekad bersama Management REVVER akan membawa REVVER menjadi Perusahaan berbasis Network Marketing terbaik di Indonesia.")
                ],
              ),
            ),
            SpacerHeight(h: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 35),
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/img/profile-management-bg.png"),
                  fit: BoxFit.cover,
                ),
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/img/PAK-HAPPY-CROP.jpg"),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Happy",
                            style: CustomFont(
                                    CustomColor.brownColor, 15, FontWeight.w600)
                                .font,
                          ),
                          Text(
                            "Sugiarto",
                            style: CustomFont(
                                    CustomColor.blackColor, 15, FontWeight.w600)
                                .font,
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: CustomColor.brownColor,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Text(
                              "CEO",
                              style: CustomFont(CustomColor.whiteColor, 10,
                                      FontWeight.w600)
                                  .font,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                      "Happy Sugiarto Tjandra Menyelesaikan pendidikan formalnya di Universitas Padjadjaran Bandung Jurusan Teknik Geologi. Namun tidak pernah bekerja dibidang Geologi. Berkarya di Industri Network Marketng (MLM) sejak tahun 1988 hingga saat ini, baik di perusahaan lokal maupun Internasional. Selain itu beliau juga sebagai Motivator / Trainer untuk berbagai industri / perusahaan / organisasi dan pendidikan.")
                ],
              ),
            ),
            SpacerHeight(h: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 35),
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/img/profile-management-bg.png"),
                  fit: BoxFit.cover,
                ),
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/img/PAK-FREDY-CROP.jpg"),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fredy",
                            style: CustomFont(
                                    CustomColor.brownColor, 15, FontWeight.w600)
                                .font,
                          ),
                          Text(
                            "Wirajaya",
                            style: CustomFont(
                                    CustomColor.blackColor, 15, FontWeight.w600)
                                .font,
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: CustomColor.brownColor,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Text(
                              "CFO  ",
                              style: CustomFont(CustomColor.whiteColor, 10,
                                      FontWeight.w600)
                                  .font,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                      "Fredy Wirajaya Lahir di Sukabumi, pada tanggal 14 Maret 1989. Pendidikan terakhir SMA, sejak berusia 18 tahun beliau sudah mulai berbisnis dan sampai sekarang sudah berkarya di dunia perhotelan, blockchain dan lain lain. Saat ini beliau berusia 33 tahun dan menjabat menjadi CFO di PT. Revival Network Internasional ( REVVER ).")
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
