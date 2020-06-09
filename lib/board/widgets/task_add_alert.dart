import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/task.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/shared/utils/validators.dart';

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
  Task _task = Task();
  @override
  void initState() {
    _userController = UserController.to;
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
              onSaved: (e) => _task.title = e,
              validator: (e) => emptyValidator(e, "Insira um título"),
              decoration: InputDecoration(labelText: "Título"),
            ),
            const SizedBox(height: 5),
            TextFormField(
              onSaved: (e) => _task.description = e,
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
      _task.status = widget.status;
      if(_userController.user.boards[widget.index].tasks == null)
        _userController.user.boards[widget.index].tasks = <Task>[];
      _userController.user.boards[widget.index].tasks.add(_task);
      await _userController.save().whenComplete(() => _callback());
    }
  }
  void _callback(){
    Navigator.pop(context);
  }
}
