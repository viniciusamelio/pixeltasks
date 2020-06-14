import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/task/controllers/task.controller.dart';
import 'package:pixeltasks/task/widgets/note_add_dialog.dart';
import 'package:pixeltasks/task/widgets/note_tile.dart';

class NoteCard extends StatefulWidget {
  final TaskController taskController;
  final UserController userController;
  const NoteCard({Key key, this.taskController, this.userController})
      : super(key: key);
  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: Column(
        children: [
          Container(
            width: screen.width,
            height: 40,
            child: Center(
              child: Text("Notas",
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: _setNoteContainerHeight(),
                    child: GetBuilder(
                      init: widget.userController,
                      builder: (_) => Scrollbar(
                        child: ListView.builder(
                          itemCount:
                              widget.taskController.currentTask.notes?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            return NoteTile(
                              task: widget.taskController.task,
                              note: widget
                                  .taskController.currentTask.notes[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screen.width,
                    child: MaterialButton(
                      color: blue,
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                      onPressed: _noteAddDialog,
                      child: Text(
                        "Adicionar nota",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  double _setNoteContainerHeight() {
    double length =
        widget.taskController.currentTask.notes?.length?.toDouble() ?? 0;
    if (length > 2) return 180;
    return length * 90;
  }

  void _noteAddDialog() {
    Get.dialog(NoteAddDialog(
        task: widget.taskController.task,
        boardIndex: widget.taskController.boardIndex));
  }
}
