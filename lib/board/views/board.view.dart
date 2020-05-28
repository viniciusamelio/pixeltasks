import 'package:flutter/material.dart';
import 'package:pixeltasks/shared/models/board.model.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/shared/widgets/color_picker.dart';

class BoardAddView extends StatefulWidget {
  @override
  _BoardAddViewState createState() => _BoardAddViewState();
}

class _BoardAddViewState extends State<BoardAddView> {
  GlobalKey<FormState> _key;
  Board _board;
  @override
  void initState() {
    _key = GlobalKey<FormState>();
    _board = Board();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: purple,
        title: Text("Adicionar Board"),
      ),
      backgroundColor: purple,
      body: Center(
        child: Container(
          height: 300,
          width: screen.width * 0.94,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Título"),
                  ),
                  const SizedBox(height: 5),
                  Text("Cor", style: TextStyle(fontSize: 20, color: dark)),
                  const SizedBox(height: 10),
                  ColorPicker(onSelect: (Color color) {
                    _board.color = color;
                    print(_board.color);
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
