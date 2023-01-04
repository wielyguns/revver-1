import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class Disease {
  int id;
  String name;
  String description;
  int disease_category_id;
  Disease({
    this.id,
    this.name,
    this.description,
    this.disease_category_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'disease_category_id': disease_category_id,
    };
  }

  factory Disease.fromMap(Map<String, dynamic> map) {
    return Disease(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      disease_category_id: map['disease_category_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Disease.fromJson(String source) =>
      Disease.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DiseaseCategory {
  int id;
  String name;
  String image;
  DiseaseCategory({
    this.id,
    this.name,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory DiseaseCategory.fromMap(Map<String, dynamic> map) {
    return DiseaseCategory(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiseaseCategory.fromJson(String source) =>
      DiseaseCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DiseaseDetail {
  int id;
  String name;
  String description;
  int disease_category_id;
  DiseaseDetail({
    this.id,
    this.name,
    this.description,
    this.disease_category_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'disease_category_id': disease_category_id,
    };
  }

  factory DiseaseDetail.fromMap(Map<String, dynamic> map) {
    return DiseaseDetail(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      disease_category_id: map['disease_category_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiseaseDetail.fromJson(String source) =>
      DiseaseDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DiseaseProduct {
  int id;
  int disease_id;
  int product_id;
  String reason;
  String product_image;
  String product_name;
  int product_price;
  DiseaseProduct({
    this.id,
    this.disease_id,
    this.product_id,
    this.reason,
    this.product_image,
    this.product_name,
    this.product_price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'disease_id': disease_id,
      'product_id': product_id,
      'reason': reason,
      'product_image': product_image,
      'product_name': product_name,
      'product_price': product_price,
    };
  }

  factory DiseaseProduct.fromMap(Map<String, dynamic> map) {
    return DiseaseProduct(
      id: map['id'] as int,
      disease_id: map['disease_id'] as int,
      product_id: map['product_id'] as int,
      reason: map['reason'] as String,
      product_image: map['product_image'] as String,
      product_name: map['product_name'] as String,
      product_price: map['product_price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiseaseProduct.fromJson(String source) =>
      DiseaseProduct.fromMap(json.decode(source) as Map<String, dynamic>);
}
