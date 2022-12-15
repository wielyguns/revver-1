import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/note.dart';
import 'package:revver/controller/test.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/note.dart' as n;
import 'package:revver/view/note/noteDetail.dart';

class Note extends StatefulWidget {
  const Note({Key key}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  bool isLoad = true;
  List<n.Note> note = [];
  getData() async {
    await getNote().then((val) {
      setState(() {
        note = val;
        isLoad = false;
      });
    });
  }

  callback() {
    if (!GoRouter.of(context).location.contains("/note-detail")) {
      getData();
      GoRouter.of(context).removeListener(callback);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        title: "Note",
        isPop: true,
      ),
      body: (isLoad)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SpacerHeight(h: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: note.length,
                      itemBuilder: (context, index) {
                        n.Note nt = note[index];
                        return Column(
                          children: [
                            (index != 0) ? SizedBox() : SizedBox(height: 15),
                            _listMenu(nt.title, nt.text, nt.id),
                            (index == note.length - 1)
                                ? SizedBox(height: 15)
                                : Divider(
                                    thickness: 1,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              )

              // Column(
              //   children: [
              //     SpacerHeight(h: 20),
              //     GridView.count(
              //       shrinkWrap: true,
              //       physics: NeverScrollableScrollPhysics(),
              //       crossAxisSpacing: 10,
              //       mainAxisSpacing: 10,
              //       crossAxisCount: 2,
              //       children: [
              //         for (var i in note)
              //           GestureDetector(
              //             onTap: () {
              //               int id = i.id;
              //               GoRouter.of(context).push("/note-detail/$id");
              //             },
              //             child: Container(
              //               padding: EdgeInsets.all(10),
              //               decoration: BoxDecoration(
              //                 color: CustomColor.oldGreyColor,
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(15)),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black.withOpacity(0.1),
              //                     spreadRadius: 0,
              //                     blurRadius: 13,
              //                     offset: Offset(0, 3),
              //                   ),
              //                 ],
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     i.title ??= "",
              //                     style: CustomFont(CustomColor.whiteColor, 14,
              //                             FontWeight.bold)
              //                         .font,
              //                   ),
              //                   Text(
              //                     i.updated_at ??= "",
              //                     style: CustomFont(
              //                             CustomColor.whiteColor, 9, null)
              //                         .font,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           )
              //       ],
              //     ),
              //   ],
              // ),
              ),
      floatingActionButton: getFAB(),
    );
  }

  getFAB() {
    return SpeedDial(
      overlayColor: Colors.grey[900],
      animatedIcon: AnimatedIcons.menu_arrow,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: CustomColor.brownColor,
      foregroundColor: CustomColor.whiteColor,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
            child: Icon(
              Icons.note,
              color: CustomColor.whiteColor,
            ),
            backgroundColor: CustomColor.brownColor,
            onTap: () async {
              GoRouter.of(context).push("/note-detail/text");
              GoRouter.of(context).addListener(callback);
            },
            label: 'Note',
            labelStyle:
                CustomFont(CustomColor.whiteColor, 14, FontWeight.bold).font,
            labelBackgroundColor: CustomColor.brownColor),
        SpeedDialChild(
            child: Icon(
              Icons.check_box,
              color: CustomColor.whiteColor,
            ),
            backgroundColor: CustomColor.brownColor,
            onTap: () async {
              GoRouter.of(context).push("/note-detail/checkbox");
              GoRouter.of(context).addListener(callback);
            },
            label: 'Checklist',
            labelStyle:
                CustomFont(CustomColor.whiteColor, 14, FontWeight.bold).font,
            labelBackgroundColor: CustomColor.brownColor),
      ],
    );
  }

  _listMenu(String title, text, int id) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(top: 0, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title ??= "",
                      overflow: TextOverflow.ellipsis,
                      style: CustomFont(CustomColor.blackColor, 14, null).font),
                  Text(text ??= "",
                      overflow: TextOverflow.ellipsis,
                      style:
                          CustomFont(CustomColor.oldGreyColor, 12, null).font),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
      onTap: () async {
        GoRouter.of(context).push("/note-detail/$id");
        GoRouter.of(context).addListener(callback);
      },
    );
  }
}
