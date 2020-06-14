import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/board.model.dart';

class BoardController {
  Board board = Board();
  int index;
  final UserController _userController;

  BoardController(this._userController);

  Future<void> delete() async {
    await Future.delayed(Duration(milliseconds: 300))
        .whenComplete(() => _userController.user.boards
            .removeWhere((element) => element == board))
        .whenComplete(() => _userController.updateExisting());
  }

  Future<void> add() async {
    board.createdAt = DateTime.now();
    _userController.user.boards.add(board);
    await _userController
        .updateExisting()
        .whenComplete(() => _userController.save());
  }
}
