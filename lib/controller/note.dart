import 'package:http/http.dart' as http;
import 'package:revver/model/note.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

getNote() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/note";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  List<Note> list = [];

  for (var data in res['data'] as List) {
    list.add(Note.fromJson(jsonEncode(data)));
  }

  return list;
}
