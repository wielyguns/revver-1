import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/leadsOverview.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/leads.dart';
import 'package:revver/controller/test.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/leads.dart' as l;

class Leads extends StatefulWidget {
  Leads({Key key}) : super(key: key);

  @override
  State<Leads> createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
  bool isLoad = true;
  List lead = [];

  getData() async {
    await getLead().then((val) {
      print(val);
      setState(() {
        lead = val;
        isLoad = false;
      });
    });
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
        body: SafeArea(
          child: (isLoad)
              ? Center(child: CircularProgressIndicator())
              : (lead.isEmpty)
                  ? Center(child: Text("Data lead tidak tersedia."))
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SpacerHeight(h: 20),
                          Text("Leads", style: CustomFont.heading24),
                          SpacerHeight(h: 20),
                          LeadsOverview(
                            cold: 1,
                            avarage: 1,
                            converted: 1,
                            hot: 1,
                            potential: 1,
                            underAvarage: 1,
                            warm: 1,
                          ),
                          SpacerHeight(h: 20),
                          SearchForm(),
                          SpacerHeight(h: 20),
                          leadsList(),
                          SpacerHeight(h: 80),
                        ],
                      ),
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push("/leads-detail-form");
          },
          backgroundColor: CustomColor.goldColor,
          child: Icon(Icons.add),
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
              ld.user_id,
              ld.name,
              ld.city_id,
              ld.status,
              ld.phone,
            ),
            SpacerHeight(h: 10),
          ],
        );
      }),
    );
  }

  leadsListWidget(id, name, city_id, status, phone) {
    return Row(
      children: [
        GestureDetector(
          onTap: (() => GoRouter.of(context).push("/leads-detail")),
          child: SizedBox(
            height: 55,
            width: 55,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://wallpaperaccess.com/full/733834.png"),
                ),
              ],
            ),
          ),
        ),
        SpacerWidth(w: 10),
        Expanded(
          child: InkWell(
            onTap: (() => GoRouter.of(context).push("/leads-detail")),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name ??= "",
                    overflow: TextOverflow.ellipsis, style: CustomFont.bold12),
                Text(city_id.toString(), style: CustomFont.regular12),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: CustomColor.blueColor,
                          size: 15,
                        ),
                        Text(
                          status ??= "Cold",
                          style: CustomFont.regular10,
                        ),
                      ],
                    ),
                    SpacerWidth(w: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: CustomColor.goldColor,
                          size: 15,
                        ),
                        Text(
                          "Warm",
                          style: CustomFont.regular10,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SpacerWidth(w: 10),
        SizedBox(
          // width: CustomScreen(context).width / 3.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  test(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/phone-solid.svg",
                    height: 20,
                  ),
                ),
              ),
              SpacerWidth(w: 5),
              GestureDetector(
                onTap: () {
                  test(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/envelope-solid.svg",
                    height: 20,
                  ),
                ),
              ),
              SpacerWidth(w: 5),
              GestureDetector(
                onTap: () {
                  test(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    "assets/svg/whatsapp.svg",
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
