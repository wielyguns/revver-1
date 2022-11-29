import 'dart:convert';

import 'package:revver/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

getProductDetail(String id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/product/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}

getProduct(String name) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/product?name=$name";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });

  var res = jsonDecode(response.body);
  List list = [];

  for (var data in res['data'] as List) {
    list.add(Product(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      price: data['price'],
      product_image: data['product_image'][0]['image'],
    ));
  }

  return list;
}
