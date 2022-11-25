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

registrationPost(
  String name,
  String username,
  String email,
  String phone,
  String sponsorId,
  String password,
  String confirmPassword,
) async {
  String url = "https://admin.revveracademy.com/api/v1/register";

  Uri parseUrl = Uri.parse(url);
  final response = await http.post(parseUrl, headers: {
    "Content-Type": "application/x-www-form-urlencoded"
  }, body: {
    'name': name,
    'username': username,
    'member_id': email,
    'email': email,
    'phone': phone,
    'sponsor_id': sponsorId,
    'password': password,
    'confirm_password': confirmPassword,
  });

  var res = jsonDecode(response.body);

  return res;
}
