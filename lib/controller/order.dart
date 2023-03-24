// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter_cart/flutter_cart.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

generateTokenMidtrans(String orderId, double totalPrice) async {
  // String serverKey = "SB-Mid-server-5UKRWMkpzEb1Ds9ERKd6uo7Z"; //Development
  // String url = 'https://app.sandbox.midtrans.com/snap/v1/transactions'; //Development

  String serverKey = "Mid-server-IvvAI0yd9sKQ1mgMUvveavfT"; //Production
  String url = 'https://app.midtrans.com/snap/v1/transactions'; //Production

  var authstring = base64.encode(utf8.encode(serverKey));
  var uri = Uri.parse(url);
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Basic $authstring"
  };

  Map body = {
    "transaction_details": {"order_id": orderId, "gross_amount": totalPrice}
  };
  var response = await http.post(uri, headers: headers, body: jsonEncode(body));

  var resBody = await jsonDecode(response.body);

  if (response.statusCode == 201) {
    return resBody['token'];
  } else {
    return;
  }
}

postOrderStore(String customer_id, no_receipt, first_name, last_name, address,
    contact, province_id, city_id, zip_code) async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  Map<String, String> data;
  var cart = FlutterCart();

  data = {
    "customer_id": customer_id,
    "total_price": cart.getTotalAmount().toInt().toString(),
    "no_receipt": no_receipt,
    "first_name": first_name,
    "last_name": last_name,
    "address": address,
    "contact": contact,
    "province_id": province_id,
    "city_id": city_id,
    "zip_code": zip_code,
  };

  for (int i = 0; i < cart.getCartItemCount(); i++) {
    data.addAll({"product_id[$i]": cart.cartItem[i].productId.toString()});
  }

  for (int i = 0; i < cart.getCartItemCount(); i++) {
    data.addAll(
        {"sub_total[$i]": cart.cartItem[i].subTotal.toInt().toString()});
  }

  for (int i = 0; i < cart.getCartItemCount(); i++) {
    data.addAll({"price[$i]": cart.cartItem[i].unitPrice.toInt().toString()});
  }

  for (int i = 0; i < cart.getCartItemCount(); i++) {
    data.addAll({"qty[$i]": cart.cartItem[i].quantity.toString()});
  }

  String url = "https://admin.revveracademy.com/api/v1/order";
  // String url = "https://webhook.site/4f724449-8502-410f-a1a7-1e3b60cab04b";

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

getPaymentMethodMidtrans(id) async {
  String username = 'SB-Mid-server-5UKRWMkpzEb1Ds9ERKd6uo7Z';
  String password = '';
  String basicAuth =
      'Basic ' + base64.encode(utf8.encode('$username:$password'));

  String url = "https://api.sandbox.midtrans.com/v2/$id/status";
  // String url = "https://webhook.site/4f724449-8502-410f-a1a7-1e3b60cab04b";

  Uri parseUrl = Uri.parse(url);
  final response = await http.get(parseUrl, headers: {
    "Authorization": basicAuth,
  });

  var res = jsonDecode(response.body);

  return res;
}
