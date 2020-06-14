import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/task.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/shared/utils/validators.dart';
import 'package:pixeltasks/task/controllers/task.controller.dart';

class TaskAddAlert extends StatefulWidget {
  final int index;
  final String status;
  const TaskAddAlert({Key key, this.index, this.status}) : super(key: key);
  @override
  _TaskAddAlertState createState() => _TaskAddAlertState();
}

class _TaskAddAlertState extends State<TaskAddAlert> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  UserController _userController;
  TaskController _taskController;
  @override
  void initState() {
    _userController = UserController.to;
    _taskController = TaskController(_userController);
    _taskController.task = Task();
    _taskController.boardIndex = widget.index;
    _taskHandler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Align(
          alignment: Alignment.center,
          child: Text(
            "Nova Tarefa",
            style: TextStyle(fontSize: 20),
          )),
      content: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              onSaved: (e) => _taskController.task.title = e,
              validator: (e) => emptyValidator(e, "Insira um título"),
              decoration: InputDecoration(labelText: "Título"),
            ),
            const SizedBox(height: 5),
            TextFormField(
              onSaved: (e) => _taskController.task.description = e,
              validator: (e) => emptyValidator(e, "Insira uma descrição"),
              decoration: InputDecoration(labelText: "Descrição"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45,
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                color: green,
                child: Text("Confirmar",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                onPressed: _addTask,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addTask() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _taskController.task.status = widget.status;
      await _taskController.add().whenComplete(() => _callback());
    }
  }

  void _callback() {
    Navigator.pop(context);
  }

  void _taskHandler() {
    if (_userController.user.boards[widget.index].tasks == null)
      _userController.user.boards[widget.index].tasks = <Task>[];
  }
}
