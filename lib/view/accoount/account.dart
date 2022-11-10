import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/test.dart';
import 'package:revver/globals.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                              backgroundImage: NetworkImage(
                                  "https://wallpaperaccess.com/full/733834.png"),
                            ),
                          ],
                        ),
                      ),
                      SpacerWidth(w: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nama Lengkap", style: CustomFont.bold16),
                          Text("Member", style: CustomFont.regular12),
                          SpacerHeight(h: 10),
                          Row(
                            children: [
                              ChangePasswordButton(
                                title: "Profile",
                                func: () {
                                  test(context);
                                },
                              ),
                              SpacerWidth(w: 5),
                              ChangePasswordButton(
                                title: "Change Password",
                                func: () {
                                  test(context);
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
                      test(context);
                    },
                  ),
                  SpacerHeight(h: 20),
                  AccountMenu(
                    title: "Privacy Policy",
                    iconTitle: "lock-solid.svg",
                    func: () {
                      test(context);
                    },
                  ),
                  SpacerHeight(h: 20),
                  AccountMenu(
                    title: "Refund Policy",
                    iconTitle: "dollar-sign-solid.svg",
                    func: () {
                      test(context);
                    },
                  ),
                  SpacerHeight(h: 20),
                  AccountMenu(
                    title: "About Apps",
                    iconTitle: "circle-info-solid.svg",
                    func: () {
                      test(context);
                    },
                  ),
                  SpacerHeight(h: 40),
                  SizedBox(
                    width: double.infinity,
                    child: IconTextButton(
                      title: "Logout",
                      iconTitle: "right-from-bracket-solid.svg",
                      buttonColor: CustomColor.redColor,
                      func: () {
                        GoRouter.of(context).go("/");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
