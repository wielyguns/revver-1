// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:revver/model/leads.dart';
import 'package:shared_preferences/shared_preferences.dart';

getLead() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/lead";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  List list = [];

  for (var data in res['data'] as List) {
    list.add(Leads.fromJson(jsonEncode(data)));
  }

  return list;
}

getLeadDetail(id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/lead/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);

  return res;
}

patchLeadDetail(
  String id,
  name,
  phone,
  status,
  status_financial,
  status_ambition,
  status_supel,
  status_teachable,
  height,
  weight,
  age,
  province_id,
  city_id,
  address,
  note,
) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/lead/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.patch(parseUrl, headers: {
    "Authorization": "Bearer $token",
  }, body: {
    'name': name,
    'phone': phone,
    'status': status,
    'status_financial': status_financial,
    'status_ambition': status_ambition,
    'status_supel': status_supel,
    'status_teachable': status_teachable,
    'height': height,
    'weight': weight,
    'age': age,
    'province_id': province_id,
    'city_id': city_id,
    'address': address,
    'note': note,
    "disease_id[]": "1"
  });
  var res = jsonDecode(response.body);

  return res;
}
