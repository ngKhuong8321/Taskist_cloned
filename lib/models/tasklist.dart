// To parse this JSON data, do
//
//     final taskList = taskListFromJson(jsonString);

import 'dart:convert';

import 'package:taskist_clone/models/task.dart';

TaskList taskListFromJson(String str) => TaskList.fromJson(json.decode(str));

String taskListToJson(TaskList data) => json.encode(data.toJson());

class NoteFields {
  static final String name = 'name';
  static final String taskList = 'taskList';
  static final String progress = 'progress';
}

class TaskList {
  TaskList({
    required this.name,
    required this.tasklist,
    required this.progress,
  });

  String name;
  List<dynamic> tasklist;
  double progress;

  List<Task> items = [];
  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
        name: json["name"],
        tasklist: List<dynamic>.from(json["tasklist"].map((x) => x)),
        progress: json["progress"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "tasklist": List<dynamic>.from(tasklist.map((x) => x)),
        "progress": progress,
      };
}
