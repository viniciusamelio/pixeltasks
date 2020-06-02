import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/models/board.model.dart';
import 'package:pixeltasks/shared/utils/color_converter.dart';

class BoardTile extends StatelessWidget {
  final Board board;
  final Widget button;
  final Function onTap;

  const BoardTile({Key key, this.board, this.button, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: convertFromString(board.color),
              borderRadius: BorderRadius.circular(12)),
          width: screen.width,
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(board.title,
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              button ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}
