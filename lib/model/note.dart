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

class NoteDetail {
  int id;
  int user_id;
  String title;
  String type;
  String updated_at;
  List<NoteList> note_list = [];
  NoteDetail({
    this.id,
    this.user_id,
    this.title,
    this.type,
    this.updated_at,
    this.note_list,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'title': title,
      'type': type,
      'updated_at': updated_at,
      'note_list': note_list.map((x) => x.toMap()).toList(),
    };
  }

  factory NoteDetail.fromMap(Map<String, dynamic> map) {
    return NoteDetail(
      id: map['id'] as int,
      user_id: map['user_id'] as int,
      title: map['title'] as String,
      type: map['type'] as String,
      updated_at: map['updated_at'] as String,
      note_list: List<NoteList>.from(
        (map['note_list'] as List<int>).map<NoteList>(
          (x) => NoteList.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteDetail.fromJson(String source) =>
      NoteDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}

class NoteList {
  int id;
  int note_id;
  String text;
  int is_check;
  NoteList({
    this.id,
    this.note_id,
    this.text,
    this.is_check,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'note_id': note_id,
      'text': text,
      'is_check': is_check,
    };
  }

  factory NoteList.fromMap(Map<String, dynamic> map) {
    return NoteList(
      id: map['id'] as int,
      note_id: map['note_id'] as int,
      text: map['text'] as String,
      is_check: map['is_check'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteList.fromJson(String source) =>
      NoteList.fromMap(json.decode(source) as Map<String, dynamic>);
}
