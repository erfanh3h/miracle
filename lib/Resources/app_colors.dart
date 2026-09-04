import 'package:flutter/material.dart';

class AppColors {
  // Existing (unchanged)
  static const primary = Color.fromARGB(255, 62, 68, 114);
  static const primaryLight = Color.fromARGB(255, 58, 83, 83);

  // Adjusted for better dark theme contrast
  static const primaryDark = Color.fromARGB(255, 55, 55, 68); // was (72,72,80)
  static const backgroundLight = Color.fromARGB(255, 241, 239, 239);
  static const backgroundDark = Color.fromARGB(
    255,
    32,
    32,
    40,
  ); // was (39,39,48)
  static const fontLight = Color.fromARGB(255, 7, 39, 39);
  static const fontDark = Color.fromARGB(
    255,
    200,
    200,
    205,
  ); // was (183,185,185)

  static const white = Color(0xffffffff);
  static const transparent = Colors.transparent;

  static const lightColor = Color.fromARGB(255, 233, 228, 228);
  static const darkColor = Color.fromARGB(255, 48, 5, 5);
  static const imageRedColor = Color.fromARGB(255, 138, 49, 49);
  static const buttonRed = Color(0xffBF283A);
  static const darkGreen = Color.fromARGB(255, 22, 112, 58);
}
