import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:smart_select/smart_select.dart';

class TaskController {

  final List<SmartSelectOption<String>> options = [
    SmartSelectOption<String>(value: 'TODO', title: 'TODO'),
    SmartSelectOption<String>(value: 'PROGRESS', title: 'PROGRESS'),
    SmartSelectOption<String>(value: 'FINISHED', title: 'FINISHED'),
  ];

  String selectedOption;

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
