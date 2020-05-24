import 'package:flutter/cupertino.dart';
import 'package:pixeltasks/shared/models/task.model.dart';

class Board {
  String title;
  Color color;
  DateTime createdAt;
  List<Task> tasks;

  Board.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    color = json['color'];
    createdAt = json['createdAt'];
    if (json['tasks'] != null) {
      for (var task in json['tasks']) {
        tasks.add(Task.fromJson(task));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String,dynamic>{};
    json['title'] = title;
    json['color'] = color;
    json['createdAt'] = createdAt;
    if (tasks != null) {
      final List<Map<String, dynamic>> jsonTasks = <Map<String, dynamic>>[];
      for (var task in tasks) {
        jsonTasks.add(task.toJson());
      }
      json['tasks'] = jsonTasks;
    }
    return json;
  }
}
