

import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/models/task.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/task/controllers/task.controller.dart';

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  Task _task;
  TaskController _taskController;
  
  @override
  void didChangeDependencies() {
    _task = ModalRoute.of(context).settings.arguments as Task;
    _taskController = TaskController();
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 3,
        title: Text(_task.title),        
      ),
      backgroundColor: _taskController.setColor(_task.status),
      body: SingleChildScrollView(
        child: Column(
          children: [ 
            
          ],
        ),
      ),
    );
  }
}