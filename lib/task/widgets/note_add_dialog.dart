import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/models/note.model.dart';
import 'package:pixeltasks/shared/models/task.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/shared/utils/validators.dart';

class NoteAddDialog extends StatefulWidget {
  final Task task;
  final int boardIndex;

  const NoteAddDialog(
      {Key key,
      @required this.task,
      @required this.boardIndex})
      : super(key: key);
  @override
  _NoteAddDialogState createState() => _NoteAddDialogState();
}

class _NoteAddDialogState extends State<NoteAddDialog> {
  GlobalKey<FormState> _key;
  Note _note = Note();
  UserController _userController;
  @override
  void initState() {
    _key = GlobalKey<FormState>();
    _userController = UserController.to;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Align(
          alignment: Alignment.center,
          child: Text(
            "Nova Nota",
            style: TextStyle(fontSize: 20),
          )),
      content: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              onSaved: (e) => _note.title = e,
              validator: (e) => emptyValidator(e, "Insira a nota"),
              decoration: InputDecoration(labelText: "Nota"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45,
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                color: green,
                child: Text("Confirmar",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                onPressed: _addNote,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addNote() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _note.createdAt = DateTime.now();
      if (_userController.user.boards[widget.boardIndex].tasks
              .singleWhere((element) => element == widget.task)
              .notes ==
          null) {
        _userController.user.boards[widget.boardIndex].tasks
            .singleWhere((element) => element == widget.task)
            .notes = [];
      }
      _userController.user.boards[widget.boardIndex].tasks
          .singleWhere((element) => element == widget.task)
          .notes
          .add(_note);
      await _userController
          .save()
          .whenComplete(() => Navigator.of(context).pop());
    }
  }
}
