import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/task.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/shared/utils/validators.dart';
import 'package:pixeltasks/task/controllers/task.controller.dart';
import 'package:smart_select/smart_select.dart';

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  Task _task;
  TaskController _taskController;
  UserController _userController;
  GlobalKey<FormState> _key;
  int _boardIndex;
  int _taskIndex;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  @override
  void initState() {
    _key = GlobalKey<FormState>();
    _userController = UserController.to;
    _taskController = TaskController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (_task == null) {
      _task = arguments['task'];
      _boardIndex = arguments['index'];
      _setTask();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark,
        elevation: 3,
        title: GetBuilder(
          init: _userController,
          builder: (_)=> Text(_task.title),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: () {},
              child: Icon(Icons.delete, color: Colors.white, size: 30),
            ),
          )
        ],
      ),
      backgroundColor: _taskController.setColor(_task.status),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: screen.width * 0.9,
              padding: const EdgeInsets.all(20),
              constraints: const BoxConstraints(minHeight: 200),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (e) => _userController
                          .user.boards[_boardIndex].tasks
                          .singleWhere((element) => element == _task)
                          .title = e,
                      controller: _titleController,
                      validator: (e) => emptyValidator(e, "Digite um título"),
                      decoration: InputDecoration(labelText: "Título"),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onSaved: (e) => _userController
                          .user.boards[_boardIndex].tasks
                          .singleWhere((element) => element == _task)
                          .description = e,
                      controller: _descriptionController,
                      validator: (e) =>
                          emptyValidator(e, "Digite uma desccrição"),
                      decoration: InputDecoration(labelText: "Descrição"),
                    ),
                    const SizedBox(height: 15),
                    GetBuilder(
                      init: _userController,
                      builder: (_) => SmartSelect<String>.single(
                          value: _taskController.selectedOption,
                          placeholder:
                              _taskController.selectedOption ?? "Selecione",
                          title: 'Status',
                          options: _taskController.options,
                          onChange: (e) {
                            _taskController.selectedOption = e;
                            _userController.updateExisting();
                          }),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: screen.width,
                      child: MaterialButton(
                        color: purple,
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 120),
                        onPressed: _validateForm,
                        child: Text(
                          "Alterar",
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
      ),
    );
  }

  void _setTask() {
    _titleController.text = _task.title;
    _descriptionController.text = _task.description;
    _taskController.selectedOption = _task.status.toUpperCase();
  }

  void _validateForm() async {
    if (_key.currentState.validate()) {
      if (_taskController.selectedOption == null) {
        Flushbar(
          title: "Status",
          message: "Selecione o status",
        ).show(context);
      } else {
        _userController.user.boards[_boardIndex].tasks
            .singleWhere((element) => element == _task)
            .status = _taskController.selectedOption;
        _key.currentState.save();
        await _userController.updateExisting().whenComplete(() => _updateFlushBar());
      }
    }
  }

  void _updateFlushBar(){
    Flushbar(
      title: "Alterada",
      duration: Duration(seconds: 3),
      message: "Task alterada com sucesso!",
    ).show(context);
  }
}
