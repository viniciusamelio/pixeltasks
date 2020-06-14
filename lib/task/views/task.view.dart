import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/shared/utils/validators.dart';
import 'package:pixeltasks/task/controllers/task.controller.dart';
import 'package:pixeltasks/task/widgets/note_card.dart';
import 'package:smart_select/smart_select.dart';

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  TaskController _taskController;
  UserController _userController;
  GlobalKey<FormState> _key;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  @override
  void initState() {
    _key = GlobalKey<FormState>();
    _initControllers();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (_taskController.task == null) {
      _taskController.task = arguments['task'];
      _taskController.boardIndex = arguments['index'];
      _setTask();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return GetBuilder(
      init: _userController,
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: dark,
          elevation: 3,
          title: GetBuilder(
            init: _userController,
            builder: (_) => Text(_taskController.task.title),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: _deleteTask,
                child: Icon(Icons.delete, color: Colors.white, size: 30),
              ),
            )
          ],
        ),
        backgroundColor: _taskController.setColor(_taskController.task.status),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                        _userController
                                .user.boards[_taskController.boardIndex].title +
                            ' -> ' +
                            _taskController.task.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: screen.width * 0.9,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (e) => _taskController.currentTask.title = e,
                          controller: _titleController,
                          validator: (e) =>
                              emptyValidator(e, "Digite um título"),
                          decoration: InputDecoration(labelText: "Título"),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          onSaved: (e) =>
                              _taskController.currentTask.description = e,
                          controller: _descriptionController,
                          validator: (e) =>
                              emptyValidator(e, "Digite uma descrição"),
                          decoration:
                              const InputDecoration(labelText: "Descrição"),
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
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 50),
                            onPressed: _validateForm,
                            child: Text(
                              "Alterar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                NoteCard(
                    taskController: _taskController,
                    userController: _userController)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setTask() {
    _titleController.text = _taskController.task.title;
    _descriptionController.text = _taskController.task.description;
    _taskController.selectedOption = _taskController.task.status.toUpperCase();
  }

  void _validateForm() async {
    if (_key.currentState.validate()) {
      if (_taskController.selectedOption == null) {
        Flushbar(
          title: "Status",
          message: "Selecione o status",
        ).show(context);
      } else {
        _key.currentState.save();
        await _taskController.update().whenComplete(() => _updateFlushBar());
        _taskController.task.status = _taskController.selectedOption;
      }
    }
  }

  void _updateFlushBar() {
    Flushbar(
      title: "Alterada",
      duration: Duration(seconds: 3),
      message: "Task alterada com sucesso!",
    ).show(context);
  }

  void _deleteTask() async {
    Navigator.of(context).popUntil((route) => route.settings.name == '/board');
    await _taskController.delete().whenComplete(() => _deleteFlushBar());
  }

  void _deleteFlushBar() {
    Flushbar(
      backgroundColor: Colors.red,
      title: "Removida",
      duration: Duration(seconds: 3),
      message: "Task removida!",
    ).show(context);
  }

  void _initControllers() {
    _userController = UserController.to;
    _taskController = TaskController(_userController);
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }
}
