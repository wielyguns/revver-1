import 'dart:convert';

class BannerModel {
  int id;
  String caption;
  String image;
  int order;
  BannerModel({
    this.id,
    this.caption,
    this.image,
    this.order,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'caption': caption,
      'image': image,
      'order': order,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as int,
      caption: map['caption'] as String,
      image: map['image'] as String,
      order: map['order'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
