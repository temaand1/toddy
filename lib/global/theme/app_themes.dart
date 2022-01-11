import 'package:flutter/material.dart';

enum AppTheme { Blue, Ogange, Green }

final appThemeData = {
  AppTheme.Blue: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
    accentColor: Colors.blue[400],
    primarySwatch: Colors.lightBlue,
  )),
  AppTheme.Ogange: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
    accentColor: Colors.orange[300],
    primarySwatch: Colors.orange,
  )),
  AppTheme.Green: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
    accentColor: Colors.lightGreen[400],
    primarySwatch: Colors.lightGreen,
  ))
};
