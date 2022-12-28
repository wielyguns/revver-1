import 'dart:convert';

import 'package:http/http.dart' as http;

generateTokenMidtrans(String orderId, double totalPrice) async {
  String serverKey = "SB-Mid-server-5UKRWMkpzEb1Ds9ERKd6uo7Z";

  String url = 'https://app.sandbox.midtrans.com/snap/v1/transactions';

  var authstring = base64.encode(utf8.encode(serverKey));
  var uri = Uri.parse(url);
  var headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Basic $authstring"
  };

  Map body = {
    "transaction_details": {"order_id": "#$orderId", "gross_amount": totalPrice}
  };
  var response = await http.post(uri, headers: headers, body: jsonEncode(body));

  var resBody = await jsonDecode(response.body);

  if (response.statusCode == 201) {
    return resBody['token'];
  } else {
    return;
  }
}
