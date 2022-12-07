import 'dart:convert';

import 'package:revver/model/ELearning.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

getELearning() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/e-learning";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  List<ELearning> list = [];

  for (var data in res['data'] as List) {
    list.add(ELearning.fromJson(jsonEncode(data)));
  }

  return list;
}
