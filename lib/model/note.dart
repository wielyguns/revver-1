import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class Note {
  int id;
  int user_id;
  String title;
  String type;
  String text;
  String updated_at;
  Note({
    this.id,
    this.user_id,
    this.title,
    this.type,
    this.text,
    this.updated_at,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'title': title,
      'type': type,
      'text': text,
      'updated_at': updated_at,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      user_id: map['user_id'] as int,
      title: map['title'] as String,
      type: map['type'] as String,
      text: map['text'] as String,
      updated_at: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);
}
