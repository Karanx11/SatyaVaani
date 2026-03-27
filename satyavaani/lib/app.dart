import 'package:flutter/material.dart';
import 'package:satyavaani/screens/main_screen.dart';

class SatyaVaaniApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SatyaVaani',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0F1A18),
        primaryColor: Color(0xFF2F6F63),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF2F6F63),
          secondary: Color(0xFFA7C9B9),
        ),
      ),
      home: MainScreen(),
    );
  }
}
