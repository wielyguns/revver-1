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
