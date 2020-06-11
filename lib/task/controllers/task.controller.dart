import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class TaskController {
  Color setColor(String status) {
    switch (status.toUpperCase()) {
      case 'TODO':
        return blue;
        break;
      case 'PROGRESS':
        return purple;
      default:
        return green;
    }
  }
}
