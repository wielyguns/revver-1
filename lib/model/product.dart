// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  int id;
  String name;
  String description;
  String usage;
  String ingridients;
  String benefits;
  int price;
  int status;
  Product({
    this.id,
    this.name,
    this.description,
    this.usage,
    this.ingridients,
    this.benefits,
    this.price,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'usage': usage,
      'ingridients': ingridients,
      'benefits': benefits,
      'price': price,
      'status': status,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      usage: map['usage'] as String,
      ingridients: map['ingridients'] as String,
      benefits: map['benefits'] as String,
      price: map['price'] as int,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
