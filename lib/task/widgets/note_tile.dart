import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/board.model.dart';
import 'package:pixeltasks/shared/models/note.model.dart';
import 'package:pixeltasks/shared/models/task.model.dart';

class NoteTile extends StatelessWidget {
  final UserController _userController = UserController.to;
  final Task task;
  final Note note;

  NoteTile({Key key, this.note, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Text(note.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
      trailing: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(DateFormat("dd/MM/yyyy").format(note.createdAt),
                style: TextStyle(color: Colors.black)),
            const SizedBox(width: 20),
            InkWell(
              onTap: () async {
                Board board = _userController.user.boards
                    .singleWhere((element) => element.tasks.contains(task));
                _userController.user.boards
                    .singleWhere((element) => element == board)
                    .tasks
                    .singleWhere((element) => element == task)
                    .notes
                    .removeWhere((element) => element == note);
                await _userController.updateExisting();
              },
              child: Icon(Icons.delete, size: 27),
            )
          ],
        ),
      ),
    );
  }
}
