import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTheme { Blue, Ogange, Green }

final appThemeData = {
  AppTheme.Blue: ThemeData(
      textTheme: TextTheme(bodyText1: GoogleFonts.lato(color: Colors.white)),
      scaffoldBackgroundColor: Colors.grey.shade800,
      backgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.cyan,
      )),
  AppTheme.Ogange: ThemeData(
      textTheme: TextTheme(bodyText1: GoogleFonts.lato(color: Colors.white)),
      scaffoldBackgroundColor: Colors.grey.shade800,
      backgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: Colors.grey.shade800,
        primarySwatch: Colors.orange,
      )),
  AppTheme.Green: ThemeData(
      textTheme: TextTheme(bodyText1: GoogleFonts.lato(color: Colors.white)),
      scaffoldBackgroundColor: Colors.grey.shade800,
      backgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: Colors.grey.shade800,
        primarySwatch: Colors.lightGreen,
      ))
};
