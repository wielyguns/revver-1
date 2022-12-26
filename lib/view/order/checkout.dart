import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/order.dart';
import 'package:revver/globals.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var cart = FlutterCart();
  final formKey = GlobalKey<FormState>();
  math.Random random = math.Random();
  TextEditingController controller = TextEditingController();

  String clientKey = "SB-Mid-client-gPdyvJ-T4J3doP8T";
  String url = "https://api.sandbox.midtrans.com";

  MidtransSDK _midtrans;

  @override
  void initState() {
    super.initState();
    initSDK();
  }

  void initSDK() async {
    if (!mounted) return;
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: clientKey,
        merchantBaseUrl: url,
        colorTheme: ColorTheme(
            colorPrimary: CustomColor.brownColor,
            colorPrimaryDark: CustomColor.brownColor,
            colorSecondary: CustomColor.backgroundColor),
        enableLog: true,
      ),
    );
    _midtrans?.setUIKitCustomSetting(
        skipCustomerDetailsPages: true, showPaymentStatus: true);
    _midtrans.setTransactionFinishedCallback((result) async {
      customSnackBar(context, false, result.orderId);
    });
  }

  @override
  void dispose() {
    _midtrans.removeTransactionFinishedCallback();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandartHeader(
        title: "",
        isPop: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpacerHeight(h: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Checkout",
                  style: CustomFont(CustomColor.brownColor, 32, FontWeight.w600)
                      .font,
                ),
              ],
            ),
            SpacerHeight(h: 40),
            Form(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    RegularForm(
                      title: "Title",
                      hint: "Hint",
                      controller: controller,
                      isValidator: true,
                    ),
                  ],
                ),
              ),
            ),
            SpacerHeight(h: 40),
            Container(
              decoration: BoxDecoration(
                color: CustomColor.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 13,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text("Your Order Summary"),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cart.getCartItemCount(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Text(cart.cartItem[index].quantity.toString()),
                            SpacerWidth(w: 5),
                            Expanded(
                              child: Text(
                                  cart.cartItem[index].productName.toString()),
                            ),
                            SpacerWidth(w: 5),
                            Text(rupiah(cart.cartItem[index].subTotal)),
                          ],
                        );
                      },
                    ),
                    SpacerHeight(h: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total"),
                        Text(rupiah(cart.getTotalAmount())),
                      ],
                    ),
                    SpacerHeight(h: 40),
                    SizedBox(
                      width: double.infinity,
                      child: IconTextButton(
                          title: "Checkout",
                          buttonColor: CustomColor.brownColor,
                          func: () async {
                            math.Random random = math.Random();
                            int randomNumber = random.nextInt(999999);
                            await generateTokenMidtrans(randomNumber.toString(),
                                    cart.getTotalAmount())
                                .then((val) {
                              if (val != null) {
                                _midtrans?.startPaymentUiFlow(token: val);
                              } else {
                                customSnackBar(context, true, "Gagal");
                              }
                            });
                          }),
                    ),
                    SpacerHeight(h: 20),
                    SizedBox(
                      width: double.infinity,
                      child: IconTextButton(
                        title: "Back To Cart",
                        buttonColor: CustomColor.whiteColor,
                        borderColor: CustomColor.brownColor,
                        textColor: CustomColor.brownColor,
                        func: () {
                          GoRouter.of(context).pop();
                        },
                      ),
                    ),
                    SpacerHeight(h: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      // ElevatedButton(
      //   child: Text("data"),
      //   onPressed: (() async {
      //     math.Random random = math.Random();
      //     int randomNumber = random.nextInt(999999);
      //     await generateTokenMidtrans(randomNumber.toString(), 10000)
      //         .then((val) {
      //       if (val != null) {
      //         _midtrans?.startPaymentUiFlow(token: val);
      //       } else {
      //         customSnackBar(context, true, "Gagal");
      //       }
      //     });
      //   }),
      // ),
    );
  }
}
