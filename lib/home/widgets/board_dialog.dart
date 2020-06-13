import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/board.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class BoardDialog extends StatelessWidget {
  final Board board;
  final UserController userController = UserController.to;
  final int index;
  BoardDialog({Key key, @required this.board, @required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(board.title, style: TextStyle(fontSize: 22)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final _board = userController.user.boards
                      .where((element) => element == board)
                      .single;
                  userController.user.boards.remove(_board);
                  await userController
                      .updateExisting()
                      .then((_) => Navigator.pop(context));
                  _deleteBoard(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: Center(
                    child: Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/board', arguments: index)
                      .then((_) => Navigator.of(context).pop());
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: blue),
                  child: Center(
                    child: Icon(Icons.list, color: Colors.white, size: 30),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _deleteBoard(BuildContext context) {
    Flushbar(
      backgroundColor: Colors.red,
      title: "Removido",
      duration: Duration(seconds: 3),
      message: "Board removido!",
    ).show(context);
  }
}
