import 'package:flutter/material.dart';

enum AppThemeMode { Dark, Light, System }

final selectedThemeMode = {
  AppThemeMode.Dark : ThemeMode.dark,
  AppThemeMode.Light : ThemeMode.light,
  AppThemeMode.System : ThemeMode.system,
};
