// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/leadsOverview.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/etc.dart';
import 'package:revver/controller/leads.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/etc.dart';
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

  List<City> city = [];
  List<City> selectedCityName = [];
  List<Province> province = [];

  List<l.Leads> lead = [];
  List<l.Leads> cold = [];
  List<l.Leads> warm = [];
  List<l.Leads> hot = [];
  List<l.Leads> converted = [];

  double potential = 0;
  double avarage = 0;
  double underAvarage = 0;

  String selectedFilterStatus = "";
  String selectedFilterFastScore = "";
  String selectedFilterLocation = "";

  getData() async {
    if (!mounted) return;
    setState(() {
      isLoad = true;
    });
    await getLead(searchController.text, selectedFilterStatus,
            selectedFilterFastScore, selectedFilterLocation)
        .then((val) {
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

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    getData();
    setState(() {});
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
                    : RefreshIndicator(
                        onRefresh: _pullRefresh,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 35),
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
                                    Text("Ringkasan Leads",
                                        style: CustomFont(
                                                CustomColor.brownColor,
                                                20,
                                                FontWeight.w700)
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
                              Row(
                                children: [
                                  Expanded(
                                    child: SearchForm(
                                      controller: searchController,
                                      callback: () {
                                        getData();
                                      },
                                    ),
                                  ),
                                  SpacerWidth(w: 10),
                                  InkWell(
                                    onTap: (() {
                                      filterModal(context);
                                    }),
                                    child: Icon(Icons.filter_list),
                                  ),
                                ],
                              ),
                              SpacerHeight(h: 20),
                              leadsList(),
                              SpacerHeight(h: 60),
                            ],
                          ),
                        ),
                      )),
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
              ld.status_teachable,
              ld.city_name,
            ),
            SpacerHeight(h: 10),
          ],
        );
      }),
    );
  }

  leadsListWidget(
    id,
    name,
    city_id,
    status,
    phone,
    image,
    ambition,
    financial,
    supel,
    teachable,
    city_name,
  ) {
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
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
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
        child: InkWell(
          onTap: (() {
            GoRouter.of(context).push("/leads-detail/$id");
            GoRouter.of(context).addListener(callback);
          }),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CustomColor.whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
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
                SpacerWidth(w: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name ??= "",
                          overflow: TextOverflow.ellipsis,
                          style: CustomFont(
                                  CustomColor.blackColor, 14, FontWeight.w600)
                              .font),
                      SpacerHeight(h: 5),
                      Text(city_name,
                          style: CustomFont(
                                  CustomColor.oldGreyColor, 10, FontWeight.w400)
                              .font),
                      SpacerHeight(h: 5),
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
                SpacerWidth(w: 10),
              ],
            ),
          ),
        ));
  }

  filterModal(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CustomColor.whiteColor,
          ),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter',
                        style: CustomFont(
                                CustomColor.blackColor, 24, FontWeight.w600)
                            .font,
                      ),
                      Row(
                        children: [
                          (selectedFilterStatus == "" &&
                                  selectedFilterFastScore == "" &&
                                  selectedFilterLocation == "")
                              ? SizedBox()
                              : InkWell(
                                  onTap: (() {
                                    setState(() {
                                      selectedFilterStatus = "";
                                      selectedFilterFastScore = "";
                                      selectedFilterLocation = "";
                                    });
                                    getData();
                                    Navigator.pop(context);
                                    filterModal(context);
                                  }),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: CustomColor.brownColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      "Reset Filter",
                                      style: CustomFont(CustomColor.whiteColor,
                                              12, FontWeight.w600)
                                          .font,
                                    ),
                                  ),
                                ),
                          InkWell(
                            onTap: (() {
                              Navigator.pop(context);
                            }),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.close),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: CustomColor.brownColor,
                    thickness: 1,
                    height: 20,
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.pop(context);
                      statusFilter(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'by Status',
                            style: CustomFont(
                                    CustomColor.blackColor, 16, FontWeight.w600)
                                .font,
                          ),
                          (selectedFilterStatus == "")
                              ? SizedBox()
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: CustomColor.blueColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    selectedFilterStatus.toUpperCase(),
                                    style: CustomFont(CustomColor.whiteColor,
                                            12, FontWeight.w600)
                                        .font,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.pop(context);
                      fastScoreFilter(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'by Fast Score',
                            style: CustomFont(
                                    CustomColor.blackColor, 16, FontWeight.w600)
                                .font,
                          ),
                          (selectedFilterFastScore == "")
                              ? SizedBox()
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: CustomColor.blueColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    selectedFilterFastScore.toUpperCase(),
                                    style: CustomFont(CustomColor.whiteColor,
                                            12, FontWeight.w600)
                                        .font,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() async {
                      if (province.isEmpty) {
                        await getProvince().then((val) {
                          setState(() {
                            province = val;
                          });
                        });
                      }
                      if (province.isNotEmpty) {
                        Navigator.pop(context);
                        locationFilter(context);
                      }
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'by Location',
                            style: CustomFont(
                                    CustomColor.blackColor, 16, FontWeight.w600)
                                .font,
                          ),
                          (selectedFilterLocation == "")
                              ? SizedBox()
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: CustomColor.blueColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Expanded(
                                    child: Text(
                                      selectedCityName[0].name,
                                      style: CustomFont(CustomColor.whiteColor,
                                              12, FontWeight.w600)
                                          .font,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  statusFilter(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CustomColor.whiteColor,
          ),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      InkWell(
                        onTap: (() {
                          Navigator.pop(context);
                          filterModal(context);
                        }),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Text(
                        'Filter Status',
                        style: CustomFont(
                                CustomColor.blackColor, 24, FontWeight.w600)
                            .font,
                      ),
                    ],
                  ),
                  Divider(
                    color: CustomColor.brownColor,
                    thickness: 1,
                    height: 20,
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        selectedFilterStatus = "Cold";
                      });
                      getData();
                      Navigator.pop(context);
                      filterModal(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cold',
                            style: CustomFont(
                                    CustomColor.blueColor, 16, FontWeight.w600)
                                .font,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        selectedFilterStatus = "Warm";
                      });
                      getData();
                      Navigator.pop(context);
                      filterModal(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Warm',
                            style: CustomFont(
                                    CustomColor.brownColor, 16, FontWeight.w600)
                                .font,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        selectedFilterStatus = "Hot";
                      });
                      getData();
                      Navigator.pop(context);
                      filterModal(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hot',
                            style: CustomFont(
                                    CustomColor.redColor, 16, FontWeight.w600)
                                .font,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        selectedFilterStatus = "Converted";
                      });
                      getData();
                      Navigator.pop(context);
                      filterModal(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Converted',
                            style: CustomFont(
                                    CustomColor.greenColor, 16, FontWeight.w600)
                                .font,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  fastScoreFilter(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CustomColor.whiteColor,
          ),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      InkWell(
                        onTap: (() {
                          Navigator.pop(context);
                          filterModal(context);
                        }),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Text(
                        'Filter Fast Score',
                        style: CustomFont(
                                CustomColor.blackColor, 24, FontWeight.w600)
                            .font,
                      ),
                    ],
                  ),
                  Divider(
                    color: CustomColor.brownColor,
                    thickness: 1,
                    height: 20,
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        selectedFilterFastScore = "potential";
                      });
                      getData();
                      Navigator.pop(context);
                      filterModal(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Potential',
                            style: CustomFont(
                                    CustomColor.blueColor, 16, FontWeight.w600)
                                .font,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        selectedFilterFastScore = "average";
                      });
                      getData();
                      Navigator.pop(context);
                      filterModal(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Avarage',
                            style: CustomFont(
                                    CustomColor.brownColor, 16, FontWeight.w600)
                                .font,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        selectedFilterFastScore = "underAverage";
                      });
                      getData();
                      Navigator.pop(context);
                      filterModal(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Under Avarage',
                            style: CustomFont(
                                    CustomColor.redColor, 16, FontWeight.w600)
                                .font,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  locationFilter(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: CustomScreen(context).height / 2,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CustomColor.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  InkWell(
                    onTap: (() {
                      Navigator.pop(context);
                      filterModal(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Text(
                    'Filter Location',
                    style:
                        CustomFont(CustomColor.blackColor, 24, FontWeight.w600)
                            .font,
                  ),
                ],
              ),
              Divider(
                color: CustomColor.brownColor,
                thickness: 1,
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: province.length,
                  itemBuilder: ((context, index) {
                    Province prov = province[index];
                    return InkWell(
                      onTap: (() async {
                        await getCity(prov.id).then((val) {
                          setState(() {
                            city = val;
                          });
                        });
                        if (city.isNotEmpty) {
                          Navigator.pop(context);
                          cityFilter(context);
                        }
                      }),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              prov.name,
                              style: CustomFont(CustomColor.blueColor, 16,
                                      FontWeight.w600)
                                  .font,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  cityFilter(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: CustomScreen(context).height / 2,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CustomColor.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  InkWell(
                    onTap: (() {
                      Navigator.pop(context);
                      locationFilter(context);
                    }),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Text(
                    'Filter Location',
                    style:
                        CustomFont(CustomColor.blackColor, 24, FontWeight.w600)
                            .font,
                  ),
                ],
              ),
              Divider(
                color: CustomColor.brownColor,
                thickness: 1,
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: city.length,
                  itemBuilder: ((context, index) {
                    City cit = city[index];
                    return InkWell(
                      onTap: (() async {
                        setState(() {
                          selectedCityName =
                              city.where((x) => x.id == cit.id).toList();
                          selectedFilterLocation = cit.id.toString();
                        });
                        getData();
                        Navigator.pop(context);
                        filterModal(context);
                      }),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cit.name,
                              style: CustomFont(CustomColor.blueColor, 16,
                                      FontWeight.w600)
                                  .font,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
