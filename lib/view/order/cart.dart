import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:revver/component/button.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/globals.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  var cart = FlutterCart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandartHeader(
        title: "",
        isPop: true,
      ),
      body: (cart.getCartItemCount() == 0)
          ? Center(
              child: Text(
                "Keranjang Kosong!",
                style: CustomFont(CustomColor.oldGreyColor, 14, FontWeight.w500)
                    .font,
              ),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SpacerHeight(h: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "My Cart",
                        style: CustomFont(
                                CustomColor.brownColor, 32, FontWeight.w600)
                            .font,
                      ),
                    ],
                  ),
                  SpacerHeight(h: 40),
                  listWidget(),
                  Divider(
                    height: 60,
                    thickness: 1.5,
                    color: CustomColor.brownColor,
                  ),
                  Text(
                    "Ringkasan Pembayaran",
                    style:
                        CustomFont(CustomColor.blackColor, 20, FontWeight.w600)
                            .font,
                  ),
                  SpacerHeight(h: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: CustomFont(
                                CustomColor.oldGreyColor, 16, FontWeight.w400)
                            .font,
                      ),
                      Text(
                        rupiah(cart.getTotalAmount()),
                        style: CustomFont(
                                CustomColor.brownColor, 24, FontWeight.w700)
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
                      func: () {
                        GoRouter.of(context).push("/checkout");
                      },
                    ),
                  ),
                  SpacerHeight(h: 20),
                  SizedBox(
                    width: double.infinity,
                    child: IconTextButton(
                      title: "Lanjutkan Belanja",
                      buttonColor: CustomColor.backgroundColor,
                      borderColor: CustomColor.brownColor,
                      textColor: CustomColor.brownColor,
                      func: () {
                        GoRouter.of(context).go("/homepage/0");
                        GoRouter.of(context).push("/product");
                      },
                    ),
                  ),
                  SpacerHeight(h: 20),
                ],
              ),
            ),
    );
  }

  listWidget() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cart.getCartItemCount(),
      itemBuilder: ((context, index) {
        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(bottom: (index == 10) ? 0 : 15),
          width: CustomScreen(context).width - 40,
          height: 105,
          decoration: BoxDecoration(
            color: CustomColor.whiteColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 13,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: CustomColor.greyColor,
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(cart.cartItem[index].productDetails)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              cart.cartItem[index].productName,
                              style: CustomFont(CustomColor.blackColor, 14,
                                      FontWeight.w600)
                                  .font,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SpacerWidth(w: 10),
                          InkWell(
                            onTap: () {
                              cart.deleteItemFromCart(index);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.highlight_remove,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      Text(
                        rupiah(cart.cartItem[index].unitPrice),
                        style: CustomFont(
                                CustomColor.oldGreyColor, 14, FontWeight.w500)
                            .font,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  cart.decrementItemFromCart(index);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: CustomColor.oldGreyColor,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: CustomColor.whiteColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                child: Text(
                                  cart.cartItem[index].quantity.toString(),
                                  style: CustomFont(CustomColor.blackColor, 15,
                                          FontWeight.w600)
                                      .font,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  cart.incrementItemToCart(index);
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: CustomColor.brownColor,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 16,
                                    color: CustomColor.whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
