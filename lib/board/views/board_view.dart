import 'package:flutter/material.dart';
import 'package:pixeltasks/board/widgets/todo_tasks.view.dart';
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
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [TodoTasksPage(index: _index), TodoTasksPage(index: _index)],
      ),
    );
  }
}
