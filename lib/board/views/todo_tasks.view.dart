import 'package:flutter/material.dart';
import 'package:pixeltasks/board/widgets/task_card.dart';

class TodoTasksView extends StatefulWidget {
  final int index;

  const TodoTasksView({Key key, this.index}) : super(key: key);
  @override
  _TodoTasksViewState createState() => _TodoTasksViewState();
}

class _TodoTasksViewState extends State<TodoTasksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
                child: TaskCard(title: "TODO", index: widget.index)),
          )),
    );
  }
}
