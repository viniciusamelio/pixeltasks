import 'package:flutter/material.dart';
import 'package:pixeltasks/login/views/login.view.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new LoginView(),
        title: Text("PixelTasks",
            style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold)),
        backgroundColor: purple,
        loaderColor: dark);
  }
}
