import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/board.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class BoardDialog extends StatelessWidget {
  final Board board;
  final UserController userController = UserController.to;
  BoardDialog({Key key, @required this.board}) : super(key: key);
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
                  final _board = userController.user.boards.where((element) => element == board).single;
                  userController.user.boards.remove(_board);
                  await userController.updateExisting().then((_) => Navigator.pop(context));
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
                onTap: () {},
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
}
