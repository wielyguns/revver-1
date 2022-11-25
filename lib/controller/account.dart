import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

postImage(String image, String name) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/account/";
  Uri parseUrl = Uri.parse(url);
  var request = http.MultipartRequest("POST", parseUrl);
  request.headers['Authorization'] = "Bearer $token";
  var file = await http.MultipartFile.fromPath(name, image);
  request.files.add(file);

  request.send().then((response) {
    print(response);
    http.Response.fromStream(response).then((onValue) {
      try {
        return onValue;
      } catch (e) {
        return e;
      }
    });
  });
}
