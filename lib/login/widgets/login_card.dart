import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  GlobalKey<FormState> _key;
  UserController _userController;
  @override
  void initState() {
    _key = GlobalKey<FormState>();
    _userController = Get.put(UserController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Container(
        height: 300,
        width: screen.width * 0.85,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(2, 5), blurRadius: 30)
            ]),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Já possui uma conta?",
                  style: TextStyle(
                      color: purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              Text("Faça login",
                  style: TextStyle(
                      color: dark, fontWeight: FontWeight.w300, fontSize: 18)),
              const SizedBox(height: 20),
              Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (e) => _userController.user.id = e,
                      validator: (e) {
                        e = e.trim();
                        if (e.isEmpty) {
                          return "Digite seu id único";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "ID"),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      onSaved: (e) => _userController.user.password = e,
                      obscureText: true,
                      validator: (e) {
                        e = e.trim();
                        if (e.isEmpty) {
                          return "Digite sua senha";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Senha"),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: screen.width,
                      child: MaterialButton(
                        color: purple,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                        onPressed: () => _loginHandler(),
                        child: Text(
                          "Entrar",
                          style: GoogleFonts.rubik(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _loginHandler() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      final check = await _userController.verifyPassword();
      _userController.user = await _userController.get(_userController.user.id.toString());
      print(check);
      if (check) {
        _navigate();
      } else {
        _onLoginError();
      }
    }
  }

  void _navigate() {
    Get.offNamedUntil('/home', (Route<dynamic> route) => false);
  }

  void _onLoginError() {
    Flushbar(
      icon: Icon(Icons.person),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
      message: "Não conseguimos te logar com os dados fornecidos",
    ).show(context);
  }
}
