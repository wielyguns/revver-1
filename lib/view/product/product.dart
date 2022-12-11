import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:indonesia/indonesia.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:revver/component/form.dart';
import 'package:revver/component/header.dart';
import 'package:revver/component/spacer.dart';
import 'package:revver/controller/product.dart';
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
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
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
                  : GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: (itemWidth / itemHeight),
                      children: List.generate(product.length, (index) {
                        p.Product prod = product[index];
                        return productWidget(
                            prod.product_image, prod.name, prod.price, prod.id);
                      }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  productWidget(String image, String name, int price, int id) {
    return GestureDetector(
      onTap: (() => GoRouter.of(context).push("/product-detail/$id")),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: CustomFont.medium12,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(rupiah(price), style: CustomFont.bold12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
