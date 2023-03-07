import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class Goal {
  int id;
  int goal_id;
  int kanan;
  int kiri;
  int sponsor;
  String created_at;
  String updated_at;
  String converted_date;
  Goal({
    this.id,
    this.goal_id,
    this.kanan,
    this.kiri,
    this.sponsor,
    this.created_at,
    this.updated_at,
    this.converted_date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'goal_id': goal_id,
      'kanan': kanan,
      'kiri': kiri,
      'sponsor': sponsor,
      'created_at': created_at,
      'updated_at': updated_at,
      'converted_date': converted_date,
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'] as int,
      goal_id: map['goal_id'] as int,
      kanan: map['kanan'] as int,
      kiri: map['kiri'] as int,
      sponsor: map['sponsor'] as int,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      converted_date: map['converted_date'] as String,
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
