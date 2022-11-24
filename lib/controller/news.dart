import 'package:http/http.dart' as http;
import 'dart:convert';

listNews(String email, String password) async {
  String url = "https://admin.revveracademy.com/api/v1/news";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl,
      headers: {"Content-Type": "application/x-www-form-urlencoded"});
  var res = jsonDecode(response.body);

  return res;
}
