import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ELearning {
  int id;
  String name;
  String description;
  String thumbnail;
  int price;
  String file;
  ELearning({
    this.id,
    this.name,
    this.description,
    this.thumbnail,
    this.price,
    this.file,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'thumbnail': thumbnail,
      'price': price,
      'file': file,
    };
  }

  factory ELearning.fromMap(Map<String, dynamic> map) {
    return ELearning(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      thumbnail: map['thumbnail'] as String,
      price: map['price'] as int,
      file: map['file'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ELearning.fromJson(String source) =>
      ELearning.fromMap(json.decode(source) as Map<String, dynamic>);
}
