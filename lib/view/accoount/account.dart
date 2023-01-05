import 'package:flutter/cupertino.dart';
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
  bool isLoad = true;
  String image;
  String name;
  String stage;

  getHeader() async {
    if (!mounted) return;
    await getAccountHeader().then((val) {
      setState(() {
        name = val['data']['name'];
        image = val['data']['avatar'];
        stage = val['data']['stage']['name'].toString();
        isLoad = false;
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
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/img/revver-horizontal.png",
          width: CustomScreen(context).width / 3,
        ),
        backgroundColor: CustomColor.backgroundColor,
        elevation: 0,
      ),
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SpacerHeight(h: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: [
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/img/revver-bg.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "My Account",
                              style: CustomFont(CustomColor.whiteColor, 32,
                                      FontWeight.w600)
                                  .font,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SpacerHeight(h: 100),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: CustomColor.whiteColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  padding: EdgeInsets.all(5),
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
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SpacerHeight(h: 10),
                  Text(
                    name,
                    style:
                        CustomFont(CustomColor.brownColor, 20, FontWeight.w600)
                            .font,
                  ),
                  SpacerHeight(h: 5),
                  Text(
                    stage,
                    style: CustomFont(
                            CustomColor.oldGreyColor, 13, FontWeight.w400)
                        .font,
                  ),
                  SpacerHeight(h: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: ChangePasswordButton(
                            title: "Profile",
                            func: () {
                              GoRouter.of(context).push("/profile");
                            },
                          ),
                        ),
                        SpacerWidth(w: 5),
                        Expanded(
                          child: ChangePasswordButton(
                            title: "Change Password",
                            func: () {
                              GoRouter.of(context).push("/change-password");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text("Account", style: CustomFont.heading24),
                        // SpacerHeight(h: 20),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       height: 80,
                        //       width: 80,
                        //       child: Stack(
                        //         clipBehavior: Clip.none,
                        //         fit: StackFit.expand,
                        //         children: [
                        //           CircleAvatar(
                        //             backgroundImage: NetworkImage(image ??=
                        //                 "https://wallpaperaccess.com/full/733834.png"),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SpacerWidth(w: 20),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(name ??= "...", style: CustomFont.bold16),
                        //         Text(stage ??= "...",
                        //             style: CustomFont.regular12),
                        //         SpacerHeight(h: 10),
                        //         Row(
                        //           children: [
                        //             ChangePasswordButton(
                        //               title: "Profile",
                        //               func: () {
                        //                 GoRouter.of(context).push("/profile");
                        //               },
                        //             ),
                        //             SpacerWidth(w: 5),
                        //             ChangePasswordButton(
                        //               title: "Change Password",
                        //               func: () {
                        //                 GoRouter.of(context)
                        //                     .push("/change-password");
                        //               },
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     )
                        //   ],
                        // ),
                        SpacerHeight(h: 20),
                        AccountMenu(
                          title: "Order History",
                          iconTitle: "cart-shopping-solid.svg",
                          func: () {
                            GoRouter.of(context).push("/order-history");
                          },
                        ),
                        Divider(
                          thickness: 0.5,
                          color: CustomColor.oldGreyColor,
                        ),
                        AccountMenu(
                          title: "Privacy Policy",
                          iconTitle: "lock-solid.svg",
                          func: () {
                            GoRouter.of(context).push("/privacy-policy");
                          },
                        ),
                        Divider(
                          thickness: 0.5,
                          color: CustomColor.oldGreyColor,
                        ),
                        AccountMenu(
                          title: "Refund Policy",
                          iconTitle: "dollar-sign-solid.svg",
                          func: () {
                            GoRouter.of(context).push("/refund-policy");
                          },
                        ),
                        Divider(
                          thickness: 0.5,
                          color: CustomColor.oldGreyColor,
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
                            // iconTitle: "right-from-bracket-solid.svg",
                            buttonColor: CustomColor.brownColor,
                            func: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove("email");
                              await prefs.remove("password");
                              GoRouter.of(context).go("/login");
                            },
                          ),
                        ),
                        SpacerHeight(h: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
