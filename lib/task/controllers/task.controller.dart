import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/task.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:smart_select/smart_select.dart';

class TaskController {
  final UserController _userController;
  Task task;
  int boardIndex;
  final List<SmartSelectOption<String>> options = [
    SmartSelectOption<String>(value: 'TODO', title: 'TODO'),
    SmartSelectOption<String>(value: 'PROGRESS', title: 'PROGRESS'),
    SmartSelectOption<String>(value: 'FINISHED', title: 'FINISHED'),
  ];

  String selectedOption;

  TaskController(this._userController);

  Task get currentTask => _userController.user.boards[boardIndex].tasks
      .singleWhere((element) => element == task);

  Future<void> update() async {
    _userController.user.boards[boardIndex].tasks
        .singleWhere((element) => element == task)
        .status = selectedOption;
    await _userController.updateExisting();
  }

  Future<void> delete() async {
    await Future.delayed(Duration(milliseconds: 300))
        .whenComplete(() => _userController.user.boards[boardIndex].tasks
            .removeWhere((element) => element == task))
        .then((_) => _userController.updateExisting());
  }

  Color setColor(String status) {
    switch (status.toUpperCase()) {
      case 'TODO':
        return blue;
        break;
      case 'PROGRESS':
        return purple;
      default:
        return Colors.green;
    }
  }
}
