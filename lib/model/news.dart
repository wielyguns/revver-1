import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class News {
  int id;
  String title;
  String image;
  String created_at;
  News({
    this.id,
    this.title,
    this.image,
    this.created_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'created_at': created_at,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] as String,
      created_at: map['created_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) =>
      News.fromMap(json.decode(source) as Map<String, dynamic>);
}

class NewsDetail {
  int id;
  String title;
  String image;
  String content;
  String url;
  int status;
  int created_by;
  int updated_by;
  String created_at;
  String updated_at;
  NewsDetail({
    this.id,
    this.title,
    this.image,
    this.content,
    this.url,
    this.status,
    this.created_by,
    this.updated_by,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'image': image,
      'content': content,
      'url': url,
      'status': status,
      'created_by': created_by,
      'updated_by': updated_by,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory NewsDetail.fromMap(Map<String, dynamic> map) {
    return NewsDetail(
      id: map['id'] as int,
      title: map['title'] as String,
      image: map['image'] as String,
      content: map['content'] as String,
      url: map['url'] as String,
      status: map['status'] as int,
      created_by: map['created_by'] as int,
      updated_by: map['updated_by'] as int,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsDetail.fromJson(String source) =>
      NewsDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
