import 'dart:convert';

import 'package:revver/model/news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

getNewsDetail(int id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/news/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}

getNews() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/news";

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
