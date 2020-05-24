import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixeltasks/shared/controllers/user.controller.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  UserController _userController;
  GlobalKey<FormState> _key;
  FocusNode _nameFocus;
  FocusNode _passwordFocus;
  @override
  void initState() {
    _key = GlobalKey<FormState>();
    _userController = UserController();
    _initFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: purple,
      appBar: AppBar(
        elevation: 0,
        title: Text("Cadastro"),
        backgroundColor: purple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            width: screen.width,
            constraints: BoxConstraints(minHeight: screen.height * 0.5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(5, 10),
                      blurRadius: 20)
                ]),
            child: Form(
              key: _key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Text('Preencha o formulário para se cadastrar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      onSaved: (e) => _userController.user.id = e,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Insira um id único";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "ID",
                          suffixIcon: IconButton(
                              icon: Icon(Icons.navigate_next),
                              onPressed: () => FocusScope.of(context)
                                  .requestFocus(_nameFocus))),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      focusNode: _nameFocus,
                      onSaved: (e) => _userController.user.name = e,
                      validator: (e) {
                        if (e.isEmpty) {
                          return "Insira o nome";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Nome",
                          suffixIcon: IconButton(
                              icon: Icon(Icons.navigate_next),
                              onPressed: () => FocusScope.of(context)
                                  .requestFocus(_passwordFocus))),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      focusNode: _passwordFocus,
                      onSaved: (e) => _userController.user.password = e,
                      validator: (e) {
                        e = e.trim();
                        if (e.isEmpty || e.length < 4) {
                          return "Insira uma senha com pelo menos 4 caracteres";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Senha",
                          suffixIcon: IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                FocusScope.of(context).nextFocus();
                                _userValidation();
                              })),
                    ),
                    const SizedBox(height: 70),
                    SizedBox(
                      width: screen.width,
                      child: MaterialButton(
                        color: green,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                        onPressed: () => _userValidation(),
                        child: GetBuilder<UserController>(
                          init: UserController(),
                          builder: (controller) => !controller.request
                              ? Text(
                                  "Concluir",
                                  style: GoogleFonts.rubik(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _userValidation() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      bool hasUser = await _userController.check();
      if (hasUser) {
        Flushbar(
          icon: Icon(Icons.person),
          backgroundColor: Colors.red,
          message: "Id de usuário já registrado neste dipositivo",
        ).show(context);
      } else {
        await _userController.save().whenComplete(() => _signUpCallBack());
      }
    }
  }

  void _signUpCallBack() {
    Get.offNamedUntil('/home', (Route<dynamic> route) => false);
  }

  void _initFocus() {
    _nameFocus = FocusNode();
    _passwordFocus = FocusNode();
  }
}
