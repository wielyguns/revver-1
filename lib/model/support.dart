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
  String current_task;
  Member({
    this.id,
    this.name,
    this.avatar,
    this.sponsor_id,
    this.stage_id,
    this.stage_name,
    this.current_task,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
      'sponsor_id': sponsor_id,
      'stage_id': stage_id,
      'stage_name': stage_name,
      'current_task': current_task,
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
      current_task: map['current_task'] as String,
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

class CurrentTask {
  int current_task_id;
  String current_task_title;
  String current_task_content;
  int current_task_status;
  CurrentTask({
    this.current_task_id,
    this.current_task_title,
    this.current_task_content,
    this.current_task_status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'current_task_id': current_task_id,
      'current_task_title': current_task_title,
      'current_task_content': current_task_content,
      'current_task_status': current_task_status,
    };
  }

  factory CurrentTask.fromMap(Map<String, dynamic> map) {
    return CurrentTask(
      current_task_id: map['current_task_id'] as int,
      current_task_title: map['current_task_title'] as String,
      current_task_content: map['current_task_content'] as String,
      current_task_status: map['current_task_status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentTask.fromJson(String source) =>
      CurrentTask.fromMap(json.decode(source) as Map<String, dynamic>);
}
