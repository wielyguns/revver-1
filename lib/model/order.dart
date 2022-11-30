import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class Order {
  int id;
  String no_receipt;
  int customer_id;
  int total_price;
  int payment_status;
  String bank_name;
  String bank_number;
  String created_at;
  Order({
    this.id,
    this.no_receipt,
    this.customer_id,
    this.total_price,
    this.payment_status,
    this.bank_name,
    this.bank_number,
    this.created_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'no_receipt': no_receipt,
      'customer_id': customer_id,
      'total_price': total_price,
      'payment_status': payment_status,
      'bank_name': bank_name,
      'bank_number': bank_number,
      'created_at': created_at,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      no_receipt: map['no_receipt'] as String,
      customer_id: map['customer_id'] as int,
      total_price: map['total_price'] as int,
      payment_status: map['payment_status'] as int,
      bank_name: map['bank_name'] as String,
      bank_number: map['bank_number'] as String,
      created_at: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
