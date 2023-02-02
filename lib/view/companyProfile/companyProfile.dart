import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  padding: EdgeInsets.all(20),
                  child: Image.asset('assets/img/revver-white.png'),
                ),
                SpacerHeight(h: 20),
                Text(
                  'PT. Revival Network Internasional (RNI) adalah Perusahaan Multi Level Marketing yang berdiri di Jakarta Pada tanggal 27 Juni 2022. Perusahaan ini didirikan Oleh Anak anak muda yang memiliki Semangat yang tinggi, Punya Visi besar dan Nasionalisme Untuk Bangsa Dan Negara.',
                  style: CustomFont(CustomColor.whiteColor, 16, FontWeight.w600)
                      .font,
                ),
                SpacerHeight(h: 40),
                listWidget('Vision & Mission', visiMisi()),
                SpacerHeight(h: 20),
                listWidget('Vision & Mission', visiMisi()),
                SpacerHeight(h: 20),
                listWidget('Vision & Mission', visiMisi()),
                SpacerHeight(h: 20),
                listWidget('Vision & Mission', visiMisi()),
                SpacerHeight(h: 20),
                listWidget('Vision & Mission', visiMisi()),
                SpacerHeight(h: 20),
                listWidget('Vision & Mission', visiMisi()),
                SpacerHeight(h: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  listWidget(String name, wd) {
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
        height: 70,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CustomColor.brownColor,
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
        child: Row(
          children: [
            Icon(
              Icons.circle,
              color: CustomColor.whiteColor,
            ),
            SpacerWidth(w: 10),
            Text(
              name,
              style:
                  CustomFont(CustomColor.whiteColor, 18, FontWeight.w600).font,
            )
          ],
        ),
      ),
    );
  }

  visiMisi() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(top: 70, left: 35, right: 35, bottom: 35),
      child: Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpacerHeight(h: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[100],
                      ),
                      child: Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SpacerHeight(h: 20),
              // Text('VISI'),
              // Text(''),
              // Text(
              //     'Menjadikan PT. Revival Network Internasional (RNI) sebagai perusahaan dari Indonesia yang mendunia dalam bidang Multi Level Marketing. Dan menjadikan usaha yang bisa mensejahterakan masyarakat dan solusi dalam penghidupan yang lebih baik'),
              // Text(''),
              // Text('MISI'),
              // Text(''),
              // Text('1. Membangun Management yang profesional. '),
              // Text(
              //     '2. Memberikan Produk produk terbaik yang berkualitas, Unik dan Inovatif.'),
              // Text(
              //     '3. Memberikan Penghasilan dan Karier jangka panjang bagi Anggota nya. '),
              // Text(
              //     '4. Memberikan pelatihan Pengembangan diri, pelatihan Online dan pelatihan marketing untuk anggota nya.'),
              // Text(
              //     '5. Memberikan fasilitas fasilitas pendukung, terutama yang berhubungan dengan dunia digital sehubungan dengan berkembangnya arah era kedepan.'),
              SizedBox(
                height: 200,
                width: 200,
                child: Center(
                  child: Text("FOYA-FOYA"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
