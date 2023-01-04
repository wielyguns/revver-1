import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class Goal {
  int id;
  int goal_id;
  int referral_rate_id;
  int qty;
  String updated_at;
  Goal({
    this.id,
    this.goal_id,
    this.referral_rate_id,
    this.qty,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'goal_id': goal_id,
      'referral_rate_id': referral_rate_id,
      'qty': qty,
      'updated_at': updated_at,
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'] as int,
      goal_id: map['goal_id'] as int,
      referral_rate_id: map['referral_rate_id'] as int,
      qty: map['qty'] as int,
      updated_at: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Goal.fromJson(String source) =>
      Goal.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ReferralRate {
  int id;
  String name;
  int price;
  int rate;
  ReferralRate({
    this.id,
    this.name,
    this.price,
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'rate': rate,
    };
  }

  factory ReferralRate.fromMap(Map<String, dynamic> map) {
    return ReferralRate(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as int,
      rate: map['rate'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferralRate.fromJson(String source) =>
      ReferralRate.fromMap(json.decode(source) as Map<String, dynamic>);
}
