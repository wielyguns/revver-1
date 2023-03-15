// ignore_for_file: non_constant_identifier_names

import 'package:http/http.dart' as http;
import 'package:revver/model/goal.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

getGoal() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/goal";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  return res;
}

getReferralRate() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/goal/referral-rate";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  List<ReferralRate> list = [];

  for (var data in res['data'] as List) {
    list.add(ReferralRate.fromJson(jsonEncode(data)));
  }

  return list;
}

deleteGoal(id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/goal/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.delete(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}

postGoal(
    String target_title, target_point, target_date, target_description) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/goal";

  Uri parseUrl = Uri.parse(url);
  final response = await http.post(parseUrl, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    "target_title": target_title,
    "target_point": target_point,
    "target_date": target_date,
    "target_description": target_description,
  });
  var res = jsonDecode(response.body);

  return res;
}

patchGoal(String target_title, target_point, target_date, target_description,
    target_id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/goal/$target_id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.patch(parseUrl, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    "target_title": target_title,
    "target_point": target_point,
    "target_date": target_date,
    "target_description": target_description,
  });
  var res = jsonDecode(response.body);

  return res;
}

postRecordProgress(String kanan, kiri, sponsor, id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/goal/progress/$id";
  // String url = "https://webhook.site/9bffa78b-30ad-4a52-9564-00106f2ce9ee";

  Uri parseUrl = Uri.parse(url);
  final response = await http.post(parseUrl, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    "kanan": kanan.isNotEmpty ? kanan : "0",
    "kiri": kiri.isNotEmpty ? kiri : "0",
    "sponsor": sponsor.isNotEmpty ? sponsor : "0",
  });
  var res = jsonDecode(response.body);

  return res;
}

deleteRecordProgress(id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/goal/history/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.delete(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}

postGoalImage(String id, image, name) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  int res;

  Map<String, String> data;
  data = {
    'id': id,
  };

  String url = "https://admin.revveracademy.com/api/v1/goal/store-image";
  Uri parseUrl = Uri.parse(url);

  var request = http.MultipartRequest('POST', parseUrl);
  request.headers['Authorization'] = "Bearer $token";
  var file = await http.MultipartFile.fromPath("image", image, filename: name);
  request.fields.addAll(data);
  request.files.add(file);

  await request.send().then((response) {
    res = response.statusCode;
  });
  return res;
}
