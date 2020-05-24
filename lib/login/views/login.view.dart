import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixeltasks/login/widgets/login_card.dart';
import 'package:pixeltasks/shared/styles/colors.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screen.height * 0.8,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        width: screen.width,
                        height: screen.height * 0.45,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesome5.list_alt,
                                  size: 40, color: Colors.white),
                              const SizedBox(width: 15),
                              Text("PixelTasks",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(color: purple),
                      ),
                    ),
                  ),
                  Positioned(
                    top: screen.height * 0.45 - 100,
                    left: 0,
                    width: screen.width,
                    child: Align(
                      alignment: Alignment.center,
                      child: LoginCard(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Não possui conta?",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: dark)),
                const SizedBox(height: 10),
                MaterialButton(
                  color: purple,
                  padding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                  onPressed: () => Get.toNamed('/signup'),
                  child: Text(
                    "Cadastrar",
                    style: GoogleFonts.rubik(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 70);
    var controlPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
