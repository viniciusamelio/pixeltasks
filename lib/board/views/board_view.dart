import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pixeltasks/board/views/finished_tasks.view.dart';
import 'package:pixeltasks/board/views/progress_tasks.view.dart';
import 'package:pixeltasks/board/views/todo_tasks.view.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/board.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/shared/utils/color_converter.dart';

class BoardView extends StatefulWidget {
  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  Board _board;
  int _index;
  UserController _userController;
  @override
  void initState() {
    _userController = UserController.to;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _index = ModalRoute.of(context).settings.arguments as int;
    _board = _userController.user.boards[_index];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: convertFromString(_board.color),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: dark,
        title: Text(_board.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: _deleteBoard,
              child: Icon(Icons.delete, color: Colors.white, size: 30),
            ),
          )
        ],
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          TodoTasksView(index: _index),
          ProgressTasksView(index: _index),
          FinishedTasksView(index: _index)
        ],
      ),
    );
  }

  void _deleteBoard() async {
    Navigator.of(context).popUntil((route) => route.settings.name == '/home');
    await Future.delayed(Duration(milliseconds: 300))
        .whenComplete(() => _userController.user.boards
            .removeWhere((element) => element == _board))
        .whenComplete(
            () => _userController.updateExisting()
            .whenComplete(() => Flushbar(
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                  title: "Removido",
                  message: "Board removido!",
                ).show(context)));
  }
}
