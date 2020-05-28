import 'package:flutter/material.dart';

class BoardTile extends StatelessWidget {

  final String title;
  final Widget button;

  const BoardTile({Key key, this.title, this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: screen.width,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[ 
            Text(title),
            button ?? Container()
          ],
        ),
      ),
    );
  }
}