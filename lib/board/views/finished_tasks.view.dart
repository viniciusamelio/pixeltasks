import 'package:flutter/material.dart';
import 'package:pixeltasks/board/widgets/task_card.dart';

class FinishedTasksView extends StatefulWidget {
  final int index;

  const FinishedTasksView({Key key, this.index}) : super(key: key);
  @override
  _FinishedTasksViewState createState() => _FinishedTasksViewState();
}

class _FinishedTasksViewState extends State<FinishedTasksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
                child: TaskCard(title: "FINISHED", index: widget.index)),
          )),
    );
  }
}
