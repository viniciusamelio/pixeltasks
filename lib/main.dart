import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixeltasks/board/views/board_add.view.dart';
import 'package:pixeltasks/board/views/board_view.dart';
import 'package:pixeltasks/home/views/home.view.dart';
import 'package:pixeltasks/login/views/login.view.dart';
import 'package:pixeltasks/login/views/signup.view.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
import 'package:pixeltasks/splash/splash.dart';
import 'package:pixeltasks/task/views/task.view.dart';
void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PixelTasks',
      navigatorKey: Get.key,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: GoogleFonts.rubik().fontFamily,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: dark),
                borderRadius: BorderRadius.circular(50)),
          )),
      routes: {
        "/": (context) => Splash(),
        "/login" : (context)=> LoginView(),
        "/signup": (context) => SignUpView(),
        '/home': (context) => HomeView(),
        '/board' : (context) => BoardView(),
        "/board/add": (context) => BoardAddView(),
        "/task" : (context) => TaskView()
      },
    );
  }
}
