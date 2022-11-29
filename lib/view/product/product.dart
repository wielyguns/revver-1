import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/product.dart';
import 'package:revver/controller/test.dart';
import 'package:revver/globals.dart';
import 'package:revver/model/product.dart' as p;

class Product extends StatefulWidget {
  const Product({Key key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  TextEditingController searchController = TextEditingController();
  List product;
  bool isLoad = true;

  getData() async {
    setState(() {
      isLoad = true;
    });
    await getProduct(searchController.text).then((val) {
      setState(() {
        product = val;
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
        appBar: CustomHeader(
          title: "Product",
          svgName: "cart-shopping-solid.svg",
          route: "/cart",
          isPop: true,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                SearchForm(
                  controller: searchController,
                  callback: () {
                    getData();
                  },
                ),
                SpacerHeight(h: 20),
                (isLoad)
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: ((context, index) {
                          return SpacerHeight(h: 10);
                        }),
                        itemCount: product.length,
                        itemBuilder: (context, index) {
                          p.Product prod = product[index];
                          return productWidget(
                            prod.product_image ??=
                                "https://wallpaperaccess.com/full/733834.png",
                            prod.name ??= "...",
                            prod.price ??= 0,
                            prod.id ??= 0,
                          );
                        },
                      ),
              ],
            )),
      ),
    );
  }

  productWidget(String image, String name, int price, int id) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: CustomColor.oldGreyColor)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => GoRouter.of(context).push("/product-detail/$id"),
            child: SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // GoRouter.of(context).push("/product-detail/$id");
                test(context);
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: CustomFont.bold12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(rupiah(price), style: CustomFont.regular10),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => test(context),
            child: Container(
              margin: EdgeInsets.all(10),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: CustomColor.goldColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SvgPicture.asset(
                  "assets/svg/cart-shopping-solid.svg",
                  color: CustomColor.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
