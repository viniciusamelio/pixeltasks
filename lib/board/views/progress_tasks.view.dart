import 'package:flutter/material.dart';
import 'package:pixeltasks/board/widgets/task_card.dart';

class ProgressTasksView extends StatefulWidget {
  final int index;

  const ProgressTasksView({Key key, this.index}) : super(key: key);
  @override
  _ProgressTasksViewState createState() => _ProgressTasksViewState();
}

class _ProgressTasksViewState extends State<ProgressTasksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
                child: TaskCard(title: "PROGRESS", index: widget.index)),
          )),
    );
  }
}
