import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  GlobalKey<FormState> _key;

  @override
  void initState() {
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 330,
        width: 315,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(2, 5), blurRadius: 30)
            ]),
        child: Column(
          children: [
            Text("Já possui uma conta?",
                style: TextStyle(
                    color: purple, fontWeight: FontWeight.bold, fontSize: 20)),
            Text("Faça login",
                style: TextStyle(
                    color: dark, fontWeight: FontWeight.w300, fontSize: 18)),
            const SizedBox(height: 20),
            Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "ID"),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Senha"),
                  ),
                  const SizedBox(height: 50),
                  MaterialButton(
                    color: purple,
                    padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                    onPressed: () {},
                    child: Text(
                      "Entrar",
                      style: GoogleFonts.rubik(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
