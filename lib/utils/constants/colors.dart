import 'package:flutter/material.dart';

class TColors{
  TColors._();

  //App basic color
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.orange;
  static const Color accent = Colors.lightBlue;

  //gradient color
  static const Gradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Colors.blue,
      Colors.white
    ]
  );
  //Text Color
  static const Color textPrimary = Colors.black;
  static const Color TextSecondary = Colors.grey;
  static const Color TextWhite = Colors.white;

  //background color
  static const Color light = Colors.white;
  static const Color dark = Colors.black;
  static const Color primarybackground = Colors.white;
  
  //background container color
  static const Color lightContainer = Colors.white;
  static const Color darkContainer = Colors.black;

  //button color
  static const Color buttonPrimary = Colors.blue;
  static const Color buttonSecondary = Colors.white;
  static const Color buttonDisabled = Colors.grey;

  //border color
  static const Color borderPrimary = Colors.white;
  static const Color borderSecondary = Colors.white70;

  //error and validation color
  static const Color error = Colors.red;
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
  static const Color info = Colors.blue;

  //neutral shades
  static const Color black = Colors.black;
  static const Color darkerGrey = Color.fromARGB(255, 48, 46, 46);
  static const Color darkGrey = Color.fromARGB(255, 73, 72, 72);
  static const Color grey= Colors.grey;
  static const Color softGrey = Color.fromARGB(255, 186, 189, 190);
  static const Color lightGrey = Color.fromARGB(255, 223, 222, 221);
  static const Color white = Colors.white;
}