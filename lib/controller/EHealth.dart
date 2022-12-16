import 'dart:convert';

import 'package:revver/model/EHealth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

getDisease() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/e-health/disease";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  List<Disease> list = [];

  for (var data in res['data'] as List) {
    list.add(Disease.fromJson(jsonEncode(data)));
  }

  return list;
}
