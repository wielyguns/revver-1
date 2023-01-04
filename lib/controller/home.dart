import 'package:http/http.dart' as http;
import 'package:revver/model/banner.dart';
import 'package:revver/model/news.dart';
import 'package:revver/model/product.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

getHomeHeader() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/home/header";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}

getHomeBanner() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/banner";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  List list = [];

  for (var data in res['data'] as List) {
    list.add(BannerModel.fromJson(jsonEncode(data)));
  }

  return list;
}

getHomeNews() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/news/latest";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  List list = [];

  for (var data in res['data'] as List) {
    list.add(News.fromJson(jsonEncode(data)));
  }

  return list;
}

getHomeProduct() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/product/latest";

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
