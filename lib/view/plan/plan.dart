// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/plan.dart';
import 'package:revver/globals.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Plan extends StatefulWidget {
  const Plan({Key key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  String data;
  PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            height: CustomScreen(context).height,
            width: CustomScreen(context).width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/BG-POTRAIT.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                      borderRadius: BorderRadius.circular(20),
                      child: SfPdfViewer.asset(
                        "assets/pdf/SLIDE-MARKETING-PLAN-POTRAIT-20230330.pdf",
                        controller: _pdfViewerController,
                        canShowScrollHead: false,
                        onPageChanged: (x) {
                          setState(() {});
                        },
                        onDocumentLoaded: (x) {
                          setState(() {});
                        },
                        scrollDirection: PdfScrollDirection.horizontal,
                        pageLayoutMode: PdfPageLayoutMode.single,
                      ),
                    ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoToLandScape(
                              goToLandscape: true,
                            ),
                          ),
                        );
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
}

class PlanLandscapeMode extends StatefulWidget {
  const PlanLandscapeMode({Key key}) : super(key: key);

  @override
  State<PlanLandscapeMode> createState() => _PlanLandscapeModeState();
}

class _PlanLandscapeModeState extends State<PlanLandscapeMode> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: CustomScreen(context).height,
            width: CustomScreen(context).width,
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
              child: SfPdfViewer.asset(
                "assets/pdf/SLIDE-MARKETING-PLAN-LANDSCAPE-20230330.pdf",
                scrollDirection: PdfScrollDirection.horizontal,
                pageLayoutMode: PdfPageLayoutMode.single,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoToLandScape extends StatefulWidget {
  GoToLandScape({Key key, this.goToLandscape}) : super(key: key);
  bool goToLandscape;

  @override
  State<GoToLandScape> createState() => _GoToLandScapeState();
}

class _GoToLandScapeState extends State<GoToLandScape> {
  @override
  void initState() {
    Timer(
      Duration(milliseconds: 500),
      (() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlanLandscapeMode()),
        ).whenComplete(() {
          Timer(
            Duration(milliseconds: 1000),
            (() {
              Navigator.pop(context);
            }),
          );
        });
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.backgroundColor,
      body: Center(child: CupertinoActivityIndicator()),
    );
  }
}
