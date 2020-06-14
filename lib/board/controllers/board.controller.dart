import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/board.model.dart';

class BoardController {
  Board board;
  int index;
  final UserController _userController;

  BoardController(this._userController);

  Future<void> delete() async {
    await Future.delayed(Duration(milliseconds: 300))
        .whenComplete(() => _userController.user.boards
            .removeWhere((element) => element == board))
        .whenComplete(() => _userController.updateExisting());
  }
}
