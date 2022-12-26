import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/controller/order.dart';
import 'package:revver/globals.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  math.Random random = math.Random();
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
      // if (result.isTransactionCanceled == false) {
      //   GoRouter.of(context).pop();
      // }
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
      appBar: CustomHeader(
        title: "Cart",
        isPop: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("data"),
          onPressed: (() async {
            math.Random random = math.Random();
            int randomNumber = random.nextInt(999999);
            await generateTokenMidtrans(randomNumber.toString(), 10000)
                .then((val) {
              if (val != null) {
                _midtrans?.startPaymentUiFlow(token: val);
              } else {
                customSnackBar(context, true, "Gagal");
              }
            });
          }),
        ),
      ),
    );
  }
}
