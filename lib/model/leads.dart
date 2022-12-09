import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class Leads {
  int id;
  int user_id;
  String name;
  String phone;
  String status;
  String status_financial;
  String status_ambition;
  String status_supel;
  String status_teachable;
  String email;
  String height;
  String weight;
  String age;
  int province_id;
  int city_id;
  String address;
  String note;
  Leads({
    this.id,
    this.user_id,
    this.name,
    this.phone,
    this.status,
    this.status_financial,
    this.status_ambition,
    this.status_supel,
    this.status_teachable,
    this.email,
    this.height,
    this.weight,
    this.age,
    this.province_id,
    this.city_id,
    this.address,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'name': name,
      'phone': phone,
      'status': status,
      'status_financial': status_financial,
      'status_ambition': status_ambition,
      'status_supel': status_supel,
      'status_teachable': status_teachable,
      'email': email,
      'height': height,
      'weight': weight,
      'age': age,
      'province_id': province_id,
      'city_id': city_id,
      'address': address,
      'note': note,
    };
  }

  factory Leads.fromMap(Map<String, dynamic> map) {
    return Leads(
      id: map['id'] as int,
      user_id: map['user_id'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      status: map['status'] as String,
      status_financial: map['status_financial'] as String,
      status_ambition: map['status_ambition'] as String,
      status_supel: map['status_supel'] as String,
      status_teachable: map['status_teachable'] as String,
      email: map['email'] as String,
      height: map['height'] as String,
      weight: map['weight'] as String,
      age: map['age'] as String,
      province_id: map['province_id'] as int,
      city_id: map['city_id'] as int,
      address: map['address'] as String,
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Leads.fromJson(String source) =>
      Leads.fromMap(json.decode(source) as Map<String, dynamic>);
}
