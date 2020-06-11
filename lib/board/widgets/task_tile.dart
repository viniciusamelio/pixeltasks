import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixeltasks/board/widgets/task_options_dialog.dart';
import 'package:pixeltasks/shared/models/task.model.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final int boardIndex;
  const TaskTile({Key key, this.task, this.boardIndex}) : super(key: key);
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/task', arguments: {
        "index" : widget.boardIndex,
        "task" : widget.task
      }),
      child: Container(
        margin: const EdgeInsets.all(6),
        width: MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.task.title,
                style: TextStyle(fontWeight: FontWeight.w600)),
            GestureDetector(onTap: _showDialog, child: Icon(Icons.menu))
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, blurRadius: 7, offset: Offset(0, 0))
            ]),
      ),
    );
  }

  void _showDialog() {
    Get.dialog(TaskOptionsDialog(task: widget.task, index: widget.boardIndex));
  }
}
