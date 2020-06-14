import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:pixeltasks/board/controllers/board.controller.dart';
import 'package:pixeltasks/board/views/finished_tasks.view.dart';
import 'package:pixeltasks/board/views/progress_tasks.view.dart';
import 'package:pixeltasks/board/views/todo_tasks.view.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/shared/utils/color_converter.dart';

class BoardView extends StatefulWidget {
  @override
  _BoardViewState createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  UserController _userController;
  BoardController _boardController;
  @override
  void initState() {
    _userController = UserController.to;
    _boardController = BoardController(_userController);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_boardController.index == null) {
      _boardController.index = ModalRoute.of(context).settings.arguments as int;
      _boardController.board =
          _userController.user.boards[_boardController.index];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: convertFromString(_boardController.board.color),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: dark,
        title: Text(_boardController.board.title),
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
          TodoTasksView(index: _boardController.index),
          ProgressTasksView(index: _boardController.index),
          FinishedTasksView(index: _boardController.index)
        ],
      ),
    );
  }

  void _deleteBoard() async {
    Navigator.of(context).popUntil((route) => route.settings.name == '/home');
    _boardController.delete().whenComplete(() => Flushbar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          title: "Removido",
          message: "Board removido!",
        ).show(context));
  }
}
