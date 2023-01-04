// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Member {
  int id;
  String name;
  String avatar;
  int sponsor_id;
  int stage_id;
  String stage_name;
  Member({
    this.id,
    this.name,
    this.avatar,
    this.sponsor_id,
    this.stage_id,
    this.stage_name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
      'sponsor_id': sponsor_id,
      'stage_id': stage_id,
      'stage_name': stage_name,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'] as int,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      sponsor_id: map['sponsor_id'] as int,
      stage_id: map['stage_id'] as int,
      stage_name: map['stage_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) =>
      Member.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Indicator {
  int id;
  int stage_id;
  String title;
  String content;
  int status;
  int vital_indicator_progress_id;
  Indicator({
    this.id,
    this.stage_id,
    this.title,
    this.content,
    this.status,
    this.vital_indicator_progress_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stage_id': stage_id,
      'title': title,
      'content': content,
      'status': status,
      'vital_indicator_progress_id': status,
    };
  }

  factory Indicator.fromMap(Map<String, dynamic> map) {
    return Indicator(
      id: map['id'] as int,
      stage_id: map['stage_id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      status: map['status'] as int,
      vital_indicator_progress_id: map['vital_indicator_progress_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Indicator.fromJson(String source) =>
      Indicator.fromMap(json.decode(source) as Map<String, dynamic>);
}
