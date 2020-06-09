import 'package:flutter/material.dart';
import 'package:pixeltasks/board/widgets/task_card.dart';

class TodoTasksPage extends StatefulWidget {
  final int index;

  const TodoTasksPage({Key key, this.index}) : super(key: key);
  @override
  _TodoTasksPageState createState() => _TodoTasksPageState();
}

class _TodoTasksPageState extends State<TodoTasksPage> {
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
