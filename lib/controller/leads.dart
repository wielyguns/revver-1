// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:revver/model/leads.dart';
import 'package:shared_preferences/shared_preferences.dart';

getLead(String name, status, fast_score, location) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url =
      "https://admin.revveracademy.com/api/v1/lead?name=$name&status=$status&fast_score=$fast_score&location=$location";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });
  var res = jsonDecode(response.body);
  List<Leads> list = [];

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

postLeadDetail(
  String name,
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
  disease,
  image,
  image_name,
  selectedGender,
) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  Map<String, String> data;
  data = {
    'name': name,
    'phone': phone,
    'status': status,
    'status_financial': status_financial,
    'status_ambition': status_ambition,
    'status_supel': status_supel,
    'status_teachable': status_teachable,
    'height': "0",
    'weight': "0",
    'age': age,
    'province_id': province_id,
    'city_id': city_id,
    'address': address,
    'note': note,
    "disease_id[]": disease,
    "gender": selectedGender
  };

  int res;
  String url = "https://admin.revveracademy.com/api/v1/lead";
  Uri parseUrl = Uri.parse(url);
  var request = http.MultipartRequest('POST', parseUrl);
  request.headers['Authorization'] = "Bearer $token";
  if (image != "") {
    var file =
        await http.MultipartFile.fromPath("image", image, filename: image_name);
    request.files.add(file);
  }
  request.fields.addAll(data);

  await request.send().then((response) {
    res = response.statusCode;
  });
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
  disease,
  image,
  image_name,
  selectedGender,
) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');

  Map<String, String> data;
  data = {
    'name': name,
    'phone': phone,
    'status': status,
    'status_financial': status_financial,
    'status_ambition': status_ambition,
    'status_supel': status_supel,
    'status_teachable': status_teachable,
    'height': "0",
    'weight': "0",
    'age': age,
    'province_id': province_id,
    'city_id': city_id,
    'address': address,
    'note': note,
    "disease_id[]": disease,
    "gender": selectedGender
  };

  int res;
  String url = "https://admin.revveracademy.com/api/v1/lead/$id?_method=PATCH";

  Uri parseUrl = Uri.parse(url);
  var request = http.MultipartRequest('POST', parseUrl);
  request.headers['Authorization'] = "Bearer $token";
  request.fields.addAll(data);
  if (image != "") {
    var file =
        await http.MultipartFile.fromPath("image", image, filename: image_name);
    request.files.add(file);
  }

  await request.send().then((response) async {
    res = response.statusCode;
  });
  return res;
}

deleteLeads(id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/lead/$id";

  Uri parseUrl = Uri.parse(url);
  final response =
      await http.delete(parseUrl, headers: {"Authorization": "Bearer $token"});
  var res = jsonDecode(response.body);

  return res;
}
