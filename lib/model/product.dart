// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Product {
  int id;
  String name;
  String description;
  int price;
  String product_image;
  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.product_image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'product_image': product_image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      product_image: map['product_image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductReview {
  int id;
  int product_id;
  String subject;
  String testimonial;
  String image;
  ProductReview({
    this.id,
    this.product_id,
    this.subject,
    this.testimonial,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': product_id,
      'subject': subject,
      'testimonial': testimonial,
      'image': image,
    };
  }

  factory ProductReview.fromMap(Map<String, dynamic> map) {
    return ProductReview(
      id: map['id'] as int,
      product_id: map['product_id'] as int,
      subject: map['subject'] as String,
      testimonial: map['testimonial'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductReview.fromJson(String source) =>
      ProductReview.fromMap(json.decode(source) as Map<String, dynamic>);
}
