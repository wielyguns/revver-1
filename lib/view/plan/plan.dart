// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Plan extends StatefulWidget {
  const Plan({Key key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  bool isLoad = true;
  String data;
  PdfViewerController _pdfViewerController;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
    _pdfViewerController = PdfViewerController();
    Timer(Duration(milliseconds: 1000), (() {
      setState(() {
        isLoad = false;
      });
    }));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: ((context, orientation) {
        return (orientation == Orientation.portrait)
            ? potraitMode()
            : landscapeMode();
      }),
    );
  }

  potraitMode() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CupertinoNavigationBarBackButton(
            color: CustomColor.whiteColor,
            onPressed: () => GoRouter.of(context).pop()),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/BG-POTRAIT.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 75, left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 3,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            SfPdfViewer.asset(
                              "assets/pdf/SLIDE-MARKETING-PLAN-POTRAIT-01.pdf",
                              controller: _pdfViewerController,
                              canShowScrollHead: false,
                              onDocumentLoaded: (x) {
                                setState(() {});
                              },
                              onPageChanged: (x) {
                                setState(() {});
                              },
                              scrollDirection: PdfScrollDirection.horizontal,
                              pageLayoutMode: PdfPageLayoutMode.single,
                            ),
                            (isLoad)
                                ? Container(
                                    color: CustomColor.backgroundColor,
                                    child: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        )),
                  ),
                ),
                SpacerHeight(h: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (() {
                        _pdfViewerController.previousPage();
                        setState(() {});
                      }),
                      child: Padding(
                        padding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(_pdfViewerController.pageNumber.toString()),
                    GestureDetector(
                      onTap: (() {
                        _pdfViewerController.nextPage();
                        setState(() {});
                      }),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SpacerWidth(w: 10),
                    GestureDetector(
                      onTap: (() {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                        ]);
                      }),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.fullscreen,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  landscapeMode() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/BG LANDSCAPE.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 36),
            child: AspectRatio(
                aspectRatio: 23.2 / 9,
                child: Stack(
                  children: [
                    SfPdfViewer.asset(
                      "assets/pdf/SLIDE-MARKETING-PLAN-LANDSCAPE-01.pdf",
                      canShowScrollHead: false,
                      scrollDirection: PdfScrollDirection.horizontal,
                      pageLayoutMode: PdfPageLayoutMode.single,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                          ]);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.fullscreen_exit,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
