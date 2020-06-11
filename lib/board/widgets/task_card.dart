import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixeltasks/board/widgets/task_add_alert.dart';
import 'package:pixeltasks/board/widgets/task_tile.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/task.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class TaskCard extends StatefulWidget {
  final int index;
  final String title;
  const TaskCard({Key key, this.title, this.index}) : super(key: key);
  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  UserController _userController;
  @override
  void initState() {
    _userController = UserController.to;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            width: screen.width,
            height: 40,
            child: Center(
              child: Text(widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)),
            ),
            decoration: BoxDecoration(
                color: dark,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
          ),
          const SizedBox(height: 10),
          GetBuilder(
            init: _userController,
            builder: (_) {
              if (_userController.user.boards[widget.index].tasks == null) {
                return Container(height: 80);
              }
              return ListView.builder(
                  itemCount: _userController.user.boards[widget.index].tasks
                      .where((element) => element.status == widget.title)
                      .length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TaskTile(
                      task: _userController.user.boards[widget.index].tasks
                          .where((element) => element.status == widget.title)
                          .toList()[index],
                      boardIndex: widget.index,
                    );
                  });
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: screen.width * 0.7,
            child: MaterialButton(
              color: green,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: Text("Adicionar",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              onPressed: _showNewTaskDialog,
            ),
          )
        ],
      ),
    );
  }

  void _showNewTaskDialog() {
    Get.dialog(TaskAddAlert(index: widget.index, status: widget.title));
  }
}
