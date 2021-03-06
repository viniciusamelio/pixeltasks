import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixeltasks/board/controllers/board.controller.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/shared/utils/validators.dart';
import 'package:pixeltasks/shared/widgets/color_picker.dart';

class BoardAddView extends StatefulWidget {
  @override
  _BoardAddViewState createState() => _BoardAddViewState();
}

class _BoardAddViewState extends State<BoardAddView> {
  GlobalKey<FormState> _key;
  BoardController _boardController;
  UserController _userController;
  @override
  void initState() {
    _key = GlobalKey<FormState>();
    _userController = UserController.to;
    _boardController = BoardController(_userController);
    _boardHandler();
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
                    onSaved: (e) => _boardController.board.title = e,
                    validator: (e) =>
                      emptyValidator(e, "Insira o título do Board")
                    ,
                    decoration: InputDecoration(labelText: "Título"),
                  ),
                  const SizedBox(height: 5),
                  Text("Cor", style: TextStyle(fontSize: 20, color: dark)),
                  const SizedBox(height: 10),
                  ColorPicker(onSelect: (Color color) {
                    _boardController.board.color = color.toString();
                  }),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: screen.width,
                    child: MaterialButton(
                      color: purple,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                      onPressed: _validate,
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validate() async {
    if (_key.currentState.validate()) {
      if (_boardController.board.color == null) {
        Get.defaultDialog(
            title: "Validação",
            middleText: "Selecione a cor para o Board",
            confirmTextColor: Colors.white,
            textConfirm: "Ok",
            onConfirm: () => Navigator.of(context).pop());
      } else {
        _key.currentState.save();
        await _boardController.add().whenComplete(
            () => Get.offNamedUntil('/home', (Route<dynamic> route) => false));
      }
    }
  }
  void _boardHandler() {
    if (_userController.user.boards == null) {
      _userController.user.boards = [];
    }
  }
}
