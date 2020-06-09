import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/task.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class TaskOptionsDialog extends StatelessWidget {
  final Task task;
  final int index;
  final UserController _userController = UserController.to;
  TaskOptionsDialog({Key key, this.task, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  _userController.user.boards[index].tasks.removeWhere((element) => element == task);
                  await _userController.updateExisting().then((_) => Navigator.pop(context));
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: Center(
                    child: Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: blue),
                  child: Center(
                    child: Icon(Icons.list, color: Colors.white, size: 30),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
 
  }
}