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

postRecordProgress(String rrate_id, qty, id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/goal/progress/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.post(parseUrl, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    "referral_rate_id[0]": rrate_id,
    "qty[0]": qty,
  });
  var res = jsonDecode(response.body);

  return res;
}
