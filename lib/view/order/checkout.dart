// ignore_for_file: non_constant_identifier_names

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/snackbar.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/account.dart';
import 'package:revver/controller/etc.dart';
import 'package:revver/controller/order.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/etc.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool isLoad = true;
  var cart = FlutterCart();
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  String clientKey = "SB-Mid-client-gPdyvJ-T4J3doP8T";
  String url = "https://api.sandbox.midtrans.com";

  MidtransSDK _midtrans;

  //Province&City
  List<Province> province = [];
  List<City> city = [];

  City selectedCity;
  Province selectedProvince;

  String customer_id;

  getData() async {
    if (!mounted) return;
    await getAccountHeader().then((val) async {
      setState(() {
        customer_id = val['data']['id'].toString();
      });
      await getProvince().then((val) async {
        setState(() {
          province = val;
          isLoad = false;
        });
      });
    });
  }

  getCityList(id) async {
    await getCity(id).then((val) {
      setState(() {
        city = val;
      });
    });
  }

  @override
  void initState() {
    getData();
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
    // _midtrans.setTransactionFinishedCallback((result) async {
    //   if (result.isTransactionCanceled) {
    //     customSnackBar(context, true, "Transaction Canceled");
    //   } else {
    //     await postOrderStore(
    //             customer_id,
    //             result.orderId,
    //             firstNameController.text,
    //             lastNameController.text,
    //             addressController.text,
    //             contactController.text,
    //             selectedProvince.id.toString(),
    //             selectedCity.id.toString(),
    //             zipCodeController.text)
    //         .then((val) {
    //       if (val['status'] == 200) {
    //         cart.deleteAllCart();
    //         String id = val['data']['orders_dt'][0]['order_id'].toString();
    //         GoRouter.of(context).push('/invoice/$id/false');
    //       } else {
    //         customSnackBar(context, true, val['status'].toString());
    //       }
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    _midtrans.removeTransactionFinishedCallback();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: StandartHeader(
          title: "",
          isPop: true,
        ),
        body: (isLoad)
            ? Center(child: CupertinoActivityIndicator())
            : SingleChildScrollView(
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
                          style: CustomFont(
                                  CustomColor.brownColor, 32, FontWeight.w600)
                              .font,
                        ),
                      ],
                    ),
                    SpacerHeight(h: 40),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [
                            RegularForm(
                              icon: 'assets/svg/new-user-edit.svg',
                              title: "First Name",
                              hint: "Your First Name",
                              controller: firstNameController,
                              isValidator: true,
                            ),
                            SpacerHeight(h: 20),
                            RegularForm(
                              icon: 'assets/svg/new-user.svg',
                              title: "Last Name",
                              hint: "Your Last Name",
                              controller: lastNameController,
                              isValidator: true,
                            ),
                            SpacerHeight(h: 20),
                            RegularForm(
                              icon: 'assets/svg/new-location.svg',
                              title: "Address",
                              hint: "Your Address",
                              controller: addressController,
                              isValidator: true,
                            ),
                            SpacerHeight(h: 20),
                            RegularForm(
                              icon: 'assets/svg/new-email.svg',
                              title: "Contact",
                              hint: "Your Contact",
                              controller: contactController,
                              isValidator: true,
                            ),
                            SpacerHeight(h: 20),
                            provinceDropdown("Province", "Your Province",
                                province, selectedProvince, true),
                            (city.isEmpty) ? SizedBox() : SpacerHeight(h: 20),
                            (city.isEmpty)
                                ? SizedBox()
                                : cityDropdown("City", "Your City", city,
                                    selectedCity, true),
                            SpacerHeight(h: 20),
                            RegularForm(
                              icon: 'assets/svg/new-post-office.svg',
                              title: "Zip Code",
                              hint: "Your Zip Code",
                              controller: zipCodeController,
                              isValidator: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SpacerHeight(h: 60),
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
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SpacerHeight(h: 35),
                            Text(
                              "Your Order Summary",
                              style: CustomFont(CustomColor.blackColor, 20,
                                      FontWeight.w600)
                                  .font,
                            ),
                            SpacerHeight(h: 20),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cart.getCartItemCount(),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "x" +
                                              cart.cartItem[index].quantity
                                                  .toString(),
                                          style: CustomFont(
                                                  CustomColor.oldGreyColor,
                                                  16,
                                                  FontWeight.w400)
                                              .font,
                                        ),
                                        SpacerWidth(w: 5),
                                        Expanded(
                                          child: Text(
                                            cart.cartItem[index].productName
                                                .toString(),
                                            style: CustomFont(
                                                    CustomColor.blackColor,
                                                    16,
                                                    FontWeight.w400)
                                                .font,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SpacerWidth(w: 5),
                                        Text(
                                          rupiah(cart.cartItem[index].subTotal),
                                          style: CustomFont(
                                                  CustomColor.blackColor,
                                                  16,
                                                  FontWeight.w600)
                                              .font,
                                        ),
                                      ],
                                    ),
                                    SpacerHeight(h: 10),
                                  ],
                                );
                              },
                            ),
                            SpacerHeight(h: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: CustomFont(CustomColor.oldGreyColor,
                                          16, FontWeight.w400)
                                      .font,
                                ),
                                Text(
                                  rupiah(cart.getTotalAmount()),
                                  style: CustomFont(CustomColor.brownColor, 24,
                                          FontWeight.w700)
                                      .font,
                                ),
                              ],
                            ),
                            SpacerHeight(h: 40),
                            SizedBox(
                              width: double.infinity,
                              child: IconTextButton(
                                  title: "Checkout",
                                  buttonColor: CustomColor.brownColor,
                                  func: () async {
                                    if (!formKey.currentState.validate()) {
                                      customSnackBar(context, true,
                                          "Complete the form first!");
                                    } else {
                                      String nw = DateFormat("yyyyMMddhhmmss")
                                          .format(DateTime.now());
                                      await generateTokenMidtrans(
                                              nw, cart.getTotalAmount())
                                          .then((val) {
                                        if (val != null) {
                                          _midtrans
                                              .startPaymentUiFlow(token: val)
                                              .whenComplete(() {
                                            _midtrans
                                                .setTransactionFinishedCallback(
                                                    (result) async {
                                              if (result
                                                  .isTransactionCanceled) {
                                                customSnackBar(context, true,
                                                    "Transaction Canceled");
                                              } else {
                                                await postOrderStore(
                                                        customer_id,
                                                        result.orderId,
                                                        firstNameController
                                                            .text,
                                                        lastNameController.text,
                                                        addressController.text,
                                                        contactController.text,
                                                        selectedProvince.id
                                                            .toString(),
                                                        selectedCity.id
                                                            .toString(),
                                                        zipCodeController.text)
                                                    .then((val) {
                                                  if (val['status'] == 200) {
                                                    cart.deleteAllCart();
                                                    String id = val['data']
                                                                ['orders_dt'][0]
                                                            ['order_id']
                                                        .toString();
                                                    GoRouter.of(context).push(
                                                        '/invoice/$id/false');
                                                  } else {
                                                    customSnackBar(
                                                        context,
                                                        true,
                                                        val['status']
                                                            .toString());
                                                  }
                                                });
                                              }
                                            });
                                          });
                                        } else {
                                          customSnackBar(
                                              context, true, "Gagal");
                                        }
                                      });
                                    }
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
                            SpacerHeight(h: 40),
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
      ),
    );
  }

  Widget provinceDropdown(
    String title,
    String hint,
    List<Province> list,
    Province selectedItem,
    bool isValidator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomFont.regular12),
        SizedBox(height: 10),
        DropdownButtonFormField(
          isExpanded: true,
          value: selectedItem,
          items: list.map((v) {
            return DropdownMenuItem(
              value: v,
              child: Text(
                v.name,
                style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400)
                    .font,
              ),
            );
          }).toList(),
          onChanged: (val) async {
            setState(() {
              selectedItem = val;
              selectedProvince = val;
              selectedCity = null;
              city = [];
            });
            await getCityList(selectedItem.id);
          },
          validator: (value) {
            if (isValidator) {
              if (value == null) {
                return 'Please enter your $title';
              }
              return null;
            } else {
              return null;
            }
          },
          dropdownColor: CustomColor.whiteColor,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: SvgPicture.asset(
              'assets/svg/new-city.svg',
              width: 28,
              height: 28,
              fit: BoxFit.scaleDown,
              color: CustomColor.brownColor,
            ),
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget cityDropdown(
    String title,
    String hint,
    List<City> list,
    City selectedItem,
    bool isValidator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomFont.regular12),
        SizedBox(height: 10),
        DropdownButtonFormField(
          isExpanded: true,
          value: selectedItem,
          items: list.map((v) {
            return DropdownMenuItem(
              value: v,
              child: Text(
                v.name,
                style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400)
                    .font,
              ),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              selectedItem = val;
              selectedCity = val;
            });
          },
          validator: (value) {
            if (isValidator) {
              if (value == null) {
                return 'Please enter your $title';
              }
              return null;
            } else {
              return null;
            }
          },
          dropdownColor: CustomColor.whiteColor,
          style: CustomFont(CustomColor.blackColor, 15, FontWeight.w400).font,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: SvgPicture.asset(
              'assets/svg/new-city.svg',
              width: 28,
              height: 28,
              fit: BoxFit.scaleDown,
              color: CustomColor.brownColor,
            ),
            hintStyle:
                CustomFont(CustomColor.oldGreyColor, 15, FontWeight.w400).font,
            contentPadding: EdgeInsets.all(10),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.brownColor),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.redColor),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  width: 1.5,
                  style: BorderStyle.solid,
                  color: CustomColor.oldGreyColor),
            ),
          ),
        ),
      ],
    );
  }
}
