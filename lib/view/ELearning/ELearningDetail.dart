// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revver/component/header.dart';
import 'package:revver/controller/ELearning.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ELearningDetail extends StatefulWidget {
  ELearningDetail({Key key, this.id}) : super(key: key);
  int id;

  @override
  State<ELearningDetail> createState() => _ELearningDetailState();
}

class _ELearningDetailState extends State<ELearningDetail> {
  bool isLoad = true;
  String name;
  String file;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  getData(id) async {
    await getELearningDetail(id).then((val) async {
      setState(() {
        name = val['data']['name'];
        file = val['data']['file'];
      });
      if (file.contains(".mp4")) {
        setState(() {
          videoPlayerController = VideoPlayerController.network(file);
        });
        await videoPlayerController.initialize();
        setState(() {
          chewieController = ChewieController(
            videoPlayerController: videoPlayerController,
            aspectRatio: videoPlayerController.value.aspectRatio,
            autoPlay: true,
          );
        });
      }
      setState(() {
        isLoad = false;
      });
    });
  }

  @override
  void initState() {
    getData(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: name ??= "",
        isPop: true,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : (file.contains(".pdf"))
              ? SfPdfViewer.network(file)
              : (file.contains(".mp4"))
                  ? Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Chewie(controller: chewieController),
                          ),
                        ),
                      ],
                    )
                  : Center(child: Text("File format not supported!")),
    );
  }
}
