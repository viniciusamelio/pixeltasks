import 'package:flutter/cupertino.dart';
import 'package:pixeltasks/shared/models/task.model.dart';

class Board {
  String title;
  String color;
  DateTime createdAt;
  List<Task> tasks = <Task>[];

  Board({this.title,this.color,this.createdAt,this.tasks});

  Board.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    color = json['color'];
    createdAt = json['createdAt'];
    if (json['tasks'] != null) {
      for (var task in json['tasks']) {
        tasks.add(Task.fromJson(task));
      }
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> json = <dynamic,dynamic>{};
    json['title'] = title;
    json['color'] = color;
    json['createdAt'] = createdAt;
    if (tasks != null) {
      final List<Map<dynamic, dynamic>> jsonTasks = <Map<dynamic, dynamic>>[];
      for (var task in tasks) {
        jsonTasks.add(task.toJson());
      }
      json['tasks'] = jsonTasks;
    }
    return json;
  }
}
