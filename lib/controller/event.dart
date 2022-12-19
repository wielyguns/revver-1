import 'dart:convert';

import 'package:revver/model/event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

getEvent() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/event";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  List<Event> list = [];

  for (var data in res['data'] as List) {
    list.add(Event.fromJson(jsonEncode(data)));
  }

  return list;
}

getEventDetail(id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/event/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}
