import 'package:http/http.dart' as http;
import 'dart:convert';

loginLoad(String email, String password) async {
  String url = "https://admin.revveracademy.com/api/v1/login";

  Uri parseUrl = Uri.parse(url);
  final response = await http.post(parseUrl, headers: {
    "Content-Type": "application/x-www-form-urlencoded"
  }, body: {
    "email": email,
    "password": password,
  });
  var res = jsonDecode(response.body);

  return res;
}
