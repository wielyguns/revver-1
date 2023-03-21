// ignore_for_file: non_constant_identifier_names

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

getNoteDetail(id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/note/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });

  var res = jsonDecode(response.body);

  return res;
}

postNote(String title, type, text, List<NoteList> note_list) async {
  Map<String, String> data;

  data = {
    "title": title,
    "type": type,
    "text": text,
  };

  if (type == "checkbox") {
    for (int i = 0; i < note_list.length; i++) {
      data.addAll({"list_text[$i]": note_list[i].text});
    }
    for (int i = 0; i < note_list.length; i++) {
      bool x = note_list[i].is_check.toString() == "1";
      data.addAll({"is_check[$i]": x.toString()});
    }
  }

  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/note";
  // String url = "https://webhook.site/de55e299-bc7b-4796-93be-6265d097047f";

  Uri parseUrl = Uri.parse(url);
  final response = await http.post(
    parseUrl,
    headers: {
      "Authorization": "Bearer $token",
    },
    body: data,
  );

  var res = jsonDecode(response.body);

  return res;
}

patchNote(String id, title, type, text, List<NoteList> note_list) async {
  Map<String, String> data;

  data = {
    "title": title,
    "type": type,
    "text": text,
  };

  if (type == "checkbox") {
    for (int i = 0; i < note_list.length; i++) {
      data.addAll({"list_text[$i]": note_list[i].text});
    }
    for (int i = 0; i < note_list.length; i++) {
      bool x = note_list[i].is_check.toString() == "1";
      data.addAll({"is_check[$i]": x.toString()});
    }
  }

  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/note/$id";
  // String url = "https://webhook.site/de55e299-bc7b-4796-93be-6265d097047f";

  Uri parseUrl = Uri.parse(url);
  final response = await http.patch(
    parseUrl,
    headers: {
      "Authorization": "Bearer $token",
    },
    body: data,
  );

  var res = jsonDecode(response.body);

  return res;
}

deleteNote(id) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  String url = "https://admin.revveracademy.com/api/v1/note/$id";

  Uri parseUrl = Uri.parse(url);
  final response = await http.delete(parseUrl, headers: {
    "Authorization": "Bearer $token",
  });

  var res = jsonDecode(response.body);

  return res;
}
