// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/leadsOverview.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/leads.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/leads.dart' as l;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Leads extends StatefulWidget {
  Leads({Key key}) : super(key: key);

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
  bool isLoad = true;
  TextEditingController searchController = TextEditingController();
  List<l.Leads> lead = [];
  List<l.Leads> cold = [];
  List<l.Leads> warm = [];
  List<l.Leads> hot = [];
  List<l.Leads> converted = [];

  double potential = 0;
  double avarage = 0;
  double underAvarage = 0;

  getData() async {
    if (!mounted) return;
    setState(() {
      isLoad = true;
    });
    await getLead(searchController.text).then((val) {
      setState(() {
        lead = val;
        cold = val.where((e) => e.status == "Cold").toList();
        warm = val.where((e) => e.status == "Warm").toList();
        hot = val.where((e) => e.status == "Hot").toList();
        converted = val.where((e) => e.status == "Converted").toList();

        for (var i = 0; i < lead.length; i++) {
          double x = double.parse(lead[i].status_ambition) +
              double.parse(lead[i].status_financial) +
              double.parse(lead[i].status_supel) +
              double.parse(lead[i].status_teachable);
          if (x <= 4) {
            underAvarage++;
          }

          if (x > 4 && x <= 8) {
            avarage++;
          }

          if (x > 8) {
            potential++;
          }
        }

        isLoad = false;
      });
    });
  }

  callback() {
    if (!GoRouter.of(context).location.contains("leads-detail")) {
      getData();
      GoRouter.of(context).removeListener(callback);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomHeader(
          title: "Leads",
          isPop: false,
        ),
        body: SafeArea(
          child: (isLoad)
              ? Center(child: CupertinoActivityIndicator())
              : (lead.isEmpty)
                  ? Center(child: Text("Data lead tidak tersedia."))
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SpacerHeight(h: 20),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: CustomColor.whiteColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Text("Leads Overview",
                                    style: CustomFont(CustomColor.brownColor,
                                            20, FontWeight.w700)
                                        .font),
                                SpacerHeight(h: 20),
                                LeadsOverview(
                                  cold: cold.length.toDouble(),
                                  avarage: avarage,
                                  converted: converted.length.toDouble(),
                                  hot: hot.length.toDouble(),
                                  potential: potential,
                                  underAvarage: underAvarage,
                                  warm: warm.length.toDouble(),
                                ),
                              ],
                            ),
                          ),
                          SpacerHeight(h: 20),
                          SearchForm(
                            controller: searchController,
                            callback: () {
                              getData();
                            },
                          ),
                          SpacerHeight(h: 20),
                          leadsList(),
                          SpacerHeight(h: 60),
                        ],
                      ),
                    ),
        ),
        floatingActionButton: SizedBox(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            onPressed: () {
              GoRouter.of(context).push("/leads-detail-form");
              GoRouter.of(context).addListener(callback);
            },
            backgroundColor: CustomColor.brownColor,
            child: Icon(
              Icons.add,
              size: 30,
            ),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
      ),
    );
  }

  leadsList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: lead.length,
      itemBuilder: ((context, index) {
        l.Leads ld = lead[index];
        return Column(
          children: [
            leadsListWidget(
                ld.id,
                ld.name,
                ld.city_id,
                ld.status,
                ld.phone,
                ld.image,
                ld.status_ambition,
                ld.status_financial,
                ld.status_supel,
                ld.status_teachable),
            SpacerHeight(h: 10),
          ],
        );
      }),
    );
  }

  leadsListWidget(id, name, city_id, status, phone, image, ambition, financial,
      supel, teachable) {
    final Uri smsUri = Uri(scheme: 'sms', path: phone);
    final Uri telUri = Uri(scheme: 'tel', path: phone);
    final Uri waUri = Uri.parse("whatsapp://send?phone=$phone");
    String statusX;
    double x = double.parse(ambition) +
        double.parse(financial) +
        double.parse(supel) +
        double.parse(teachable);
    if (x <= 4) {
      statusX = "Under Avarage";
    }

    if (x > 4 && x <= 8) {
      statusX = "Avarage";
    }

    if (x > 8) {
      statusX = "Potential";
    }
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SpacerWidth(w: 10),
          SlidableAction(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            onPressed: (val) async {
              await launch(smsUri.toString());
            },
            backgroundColor: CustomColor.brownColor,
            foregroundColor: Colors.white,
            icon: Icons.message,
          ),
          SlidableAction(
            onPressed: (val) async {
              await launch(telUri.toString());
            },
            backgroundColor: CustomColor.brownColor,
            foregroundColor: Colors.white,
            icon: Icons.phone,
          ),
          SlidableAction(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            onPressed: (val) async {
              await launch(waUri.toString());
            },
            backgroundColor: CustomColor.brownColor,
            foregroundColor: Colors.white,
            icon: Icons.whatsapp,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: (() {
                GoRouter.of(context).push("/leads-detail/$id");
                GoRouter.of(context).addListener(callback);
              }),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      image ??= "https://wallpaperaccess.com/full/733834.png",
                    ),
                  ),
                ),
              ),
            ),
            SpacerWidth(w: 20),
            Expanded(
              child: InkWell(
                onTap: (() {
                  GoRouter.of(context).push("/leads-detail/$id");
                  GoRouter.of(context).addListener(callback);
                }),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ??= "",
                        overflow: TextOverflow.ellipsis,
                        style: CustomFont(
                                CustomColor.blackColor, 14, FontWeight.w600)
                            .font),
                    SpacerHeight(h: 10),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: CustomColor.blueColor,
                              size: 15,
                            ),
                            SpacerWidth(w: 5),
                            Text(
                              status ??= "Cold",
                              style: CustomFont(CustomColor.oldGreyColor, 10,
                                      FontWeight.w400)
                                  .font,
                            ),
                          ],
                        ),
                        SpacerWidth(w: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: CustomColor.brownColor,
                              size: 15,
                            ),
                            SpacerWidth(w: 5),
                            Text(
                              statusX,
                              style: CustomFont(CustomColor.oldGreyColor, 10,
                                      FontWeight.w400)
                                  .font,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // SpacerWidth(w: 10),
            // Text(city_id.toString(),
            //     style: CustomFont(CustomColor.oldGreyColor, 13, FontWeight.w400)
            //         .font),
          ],
        ),
      ),
    );
  }
}


// return Row(
//   children: [
//     GestureDetector(
//       onTap: (() {
//         GoRouter.of(context).push("/leads-detail/$id");
//         GoRouter.of(context).addListener(callback);
//       }),
//       child: SizedBox(
//         height: 55,
//         width: 55,
//         child: Stack(
//           clipBehavior: Clip.none,
//           fit: StackFit.expand,
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(
//                   image ??= "https://wallpaperaccess.com/full/733834.png"),
//             ),
//           ],
//         ),
//       ),
//     ),
//     SpacerWidth(w: 10),
//     Expanded(
//       child: InkWell(
//         onTap: (() {
//           GoRouter.of(context).push("/leads-detail/$id");
//           GoRouter.of(context).addListener(callback);
//         }),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(name ??= "",
//                 overflow: TextOverflow.ellipsis, style: CustomFont.bold12),
//             Text(city_id.toString(), style: CustomFont.regular12),
//             Row(
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.circle,
//                       color: CustomColor.blueColor,
//                       size: 15,
//                     ),
//                     SpacerWidth(w: 2),
//                     Text(
//                       status ??= "Cold",
//                       style: CustomFont.regular10,
//                     ),
//                   ],
//                 ),
//                 SpacerWidth(w: 10),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.circle,
//                       color: CustomColor.brownColor,
//                       size: 15,
//                     ),
//                     SpacerWidth(w: 2),
//                     Text(
//                       statusX,
//                       style: CustomFont.regular10,
//                     ),
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     ),
//     SpacerWidth(w: 10),
//     SizedBox(
//       // width: CustomScreen(context).width / 3.3,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: () async {
//               await launch(telUri.toString());
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(5),
//               child: SvgPicture.asset(
//                 "assets/svg/phone-solid.svg",
//                 height: 20,
//               ),
//             ),
//           ),
//           SpacerWidth(w: 5),
//           GestureDetector(
//             onTap: () async {
//               await launch(smsUri.toString());
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(5),
//               child: SvgPicture.asset(
//                 "assets/svg/envelope-solid.svg",
//                 height: 20,
//               ),
//             ),
//           ),
//           SpacerWidth(w: 5),
//           GestureDetector(
//             onTap: () async {
//               await launch(waUri.toString());
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(5),
//               child: SvgPicture.asset(
//                 "assets/svg/whatsapp.svg",
//                 height: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ],
// );