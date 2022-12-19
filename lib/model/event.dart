import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Event {
  int id;
  String name;
  String date;
  String description;
  Event({
    this.id,
    this.name,
    this.date,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'date': date,
      'description': description,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as int,
      name: map['name'] as String,
      date: map['date'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);
}
