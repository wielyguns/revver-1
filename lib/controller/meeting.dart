// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:revver/model/meeting.dart';
import 'package:shared_preferences/shared_preferences.dart';

getMeeting() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/meeting";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  List<Meeting> list = [];

  for (var data in res['data'] as List) {
    list.add(Meeting.fromJson(jsonEncode(data)));
  }

  return list;
}

getMeetingDetail(id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/meeting/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}

postMeeting(
    String lead_id, name, date, description, location, is_meeting) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/meeting";

  Uri parseUrl = Uri.parse(url);
  final response = await http.post(parseUrl, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    "lead_id": lead_id,
    "name": name,
    "date": date,
    "description": description,
    "location": location,
    "is_meeting": is_meeting,
  });
  var res = jsonDecode(response.body);

  return res;
}

patchMeeting(
    String id, lead_id, name, date, description, location, is_meeting) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/meeting/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.patch(parseUrl, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    "lead_id": lead_id,
    "name": name,
    "date": date,
    "description": description,
    "location": location,
    "is_meeting": is_meeting,
  });
  var res = jsonDecode(response.body);

  return res;
}
