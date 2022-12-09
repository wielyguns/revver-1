import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

class Meeting {
  int id;
  int lead_id;
  int user_id;
  String name;
  String date;
  String description;
  String location;
  Meeting({
    this.id,
    this.lead_id,
    this.user_id,
    this.name,
    this.date,
    this.description,
    this.location,
  });

  @override
  String toString() {
    return 'Meeting(id: $id, lead_id: $lead_id, user_id: $user_id, name: $name, date: $date, description: $description, location: $location)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lead_id': lead_id,
      'user_id': user_id,
      'name': name,
      'date': date,
      'description': description,
      'location': location,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      id: map['id'] as int,
      lead_id: map['lead_id'] as int,
      user_id: map['user_id'] as int,
      name: map['name'] as String,
      date: map['date'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meeting.fromJson(String source) =>
      Meeting.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MeetingDetail {
  int id;
  int lead_id;
  int user_id;
  String name;
  String date;
  String description;
  String location;
  MeetingDetail({
    this.id,
    this.lead_id,
    this.user_id,
    this.name,
    this.date,
    this.description,
    this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lead_id': lead_id,
      'user_id': user_id,
      'name': name,
      'date': date,
      'description': description,
      'location': location,
    };
  }

  factory MeetingDetail.fromMap(Map<String, dynamic> map) {
    return MeetingDetail(
      id: map['id'] as int,
      lead_id: map['lead_id'] as int,
      user_id: map['user_id'] as int,
      name: map['name'] as String,
      date: map['date'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MeetingDetail.fromJson(String source) =>
      MeetingDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
