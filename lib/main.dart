import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixeltasks/login/views/login.view.dart';
import 'package:pixeltasks/shared/styles/colors.dart';
void main() async {  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PixelTasks',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.rubik().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(vertical: 13,horizontal:20),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: dark
            ),
            borderRadius: BorderRadius.circular(50)
          ),
        )
      ),
      routes: {"/": (context) => LoginView()},
    );
  }
}
