// ignore_for_file: non_constant_identifier_names

import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
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

  return res;
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

Future<int> postChangeAvatar(String image, String name) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  int res;

  // String url = "https://admin.revveracademy.com/api/v1/account/";
  String url = "https://webhook.site/a80fd997-9a6b-4d57-9db2-958f90bb1b09";
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

// postChangeAvatar(io.File image, String name) async {
//   final prefs = await SharedPreferences.getInstance();
//   String token = prefs.getString('token');
//   String url = "https://admin.revveracademy.com/api/v1/account/";
//   // String url = "https://webhook.site/a80fd997-9a6b-4d57-9db2-958f90bb1b09";
//   final dio = Dio();

//   var formData = FormData.fromMap(
//       {'avatar': await MultipartFile.fromFile(image.path, filename: name)});

//   Response response = await dio.post(
//     url,
//     data: formData,
//     options: Options(
//       headers: {
//         'Content-Type': 'multipart/form-data',
//         'Authorization': 'Bearer $token',
//       },
//     ),
//   );
//   print(response);
// }

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
