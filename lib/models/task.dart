import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class TaskFields {
  static final List<String> values = [id, taskName, done];

  static final String id = 'id';
  static final String taskName = 'taskname';
  static final String done = 'done';
}

class Task {
  Task({
    required this.id,
    required this.taskName,
    required this.done,
  });

  int? id;
  String taskName;
  bool done;

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['id'] = id;
    m['taskname'] = taskName;
    m['done'] = done;

    return m;
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        taskName: json["taskname"],
        done: json["done"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "taskname": taskName,
        "done": done,
      };

  Task copy({
    int? id,
    String? taskName,
    bool? done,
  }) =>
      Task(id: this.id, taskName: this.taskName, done: this.done);
}
