import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/account.dart';
import 'package:revver/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String image;
  String name;
  String stage;

  getHeader() async {
    await getAccountHeader().then((val) {
      setState(() {
        name = val['data']['name'];
        image = val['data']['avatar'];
        stage = val['data']['stage_id'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getHeader();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SpacerHeight(h: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Account", style: CustomFont.heading24),
                    SpacerHeight(h: 20),
                    Row(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(image ??=
                                    "https://wallpaperaccess.com/full/733834.png"),
                              ),
                            ],
                          ),
                        ),
                        SpacerWidth(w: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name ??= "...", style: CustomFont.bold16),
                            Text(stage ??= "...", style: CustomFont.regular12),
                            SpacerHeight(h: 10),
                            Row(
                              children: [
                                ChangePasswordButton(
                                  title: "Profile",
                                  func: () {
                                    GoRouter.of(context).push("/profile");
                                  },
                                ),
                                SpacerWidth(w: 5),
                                ChangePasswordButton(
                                  title: "Change Password",
                                  func: () {
                                    GoRouter.of(context)
                                        .push("/change-password");
                                  },
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SpacerHeight(h: 40),
                    AccountMenu(
                      title: "Order History",
                      iconTitle: "cart-shopping-solid.svg",
                      func: () {
                        GoRouter.of(context).push("/order-history");
                      },
                    ),
                    AccountMenu(
                      title: "Privacy Policy",
                      iconTitle: "lock-solid.svg",
                      func: () {
                        GoRouter.of(context).push("/privacy-policy");
                      },
                    ),
                    AccountMenu(
                      title: "Refund Policy",
                      iconTitle: "dollar-sign-solid.svg",
                      func: () {
                        GoRouter.of(context).push("/refund-policy");
                      },
                    ),
                    AccountMenu(
                      title: "About Apps",
                      iconTitle: "circle-info-solid.svg",
                      func: () {
                        GoRouter.of(context).push("/about-apps");
                      },
                    ),
                    SpacerHeight(h: 20),
                    SizedBox(
                      width: double.infinity,
                      child: IconTextButton(
                        title: "Logout",
                        iconTitle: "right-from-bracket-solid.svg",
                        buttonColor: CustomColor.redColor,
                        func: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove("email");
                          await prefs.remove("password");
                          GoRouter.of(context).go("/login");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
