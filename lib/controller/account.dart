// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'package:revver/model/order.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

getAccountHeader() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/account/header";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}

getAccountProfile() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/account/";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}

patchAccountChangePassword(String password) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/account";

  Uri parseUrl = Uri.parse(url);
  final response = await http.patch(parseUrl, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    'password': password
  });
  var res = jsonDecode(response.body);

  return res;
}

getAccountOrder() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/account/order";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  List<Order> list = [];

  for (var data in res['data'] as List) {
    list.add(Order.fromJson(jsonEncode(data)));
  }

  return list;
}

getAccountOrderDetail(String orderId) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/account/order/$orderId";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}

postChangeAvatar(String image, String name) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  int res;

  String url = "https://admin.revveracademy.com/api/v1/account";
  Uri parseUrl = Uri.parse(url);

  var request = http.MultipartRequest('POST', parseUrl);
  request.headers['Authorization'] = "Bearer $token";
  // request.headers['Content-Type'] = "multipart/form-data";
  var file = await http.MultipartFile.fromPath("avatar", image, filename: name);
  request.files.add(file);

  await request.send().then((response) {
    res = response.statusCode;
  });
  return res;
}

patchAccountProfile(name, username, phone, secondary_email) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/account";

  Uri parseUrl = Uri.parse(url);
  final response = await http.patch(parseUrl, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    'name': name,
    'username': username,
    'phone': phone,
    'secondary_email': secondary_email,
  });
  var res = jsonDecode(response.body);

  return res;
}

deleteAccount() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/account/7";

  Uri parseUrl = Uri.parse(url);
  final response =
      await http.delete(parseUrl, headers: {"Authorization": "Bearer $token"});
  var res = jsonDecode(response.body);

  return res;
}
