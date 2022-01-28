import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toddyapp/global/theme/app_themes.dart';
import 'package:toddyapp/services/get_initial_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(AppTheme initTheme, initMode)
      : super(ThemeState(appThemeData[initTheme], initMode)) {
    on<ThemeModeChanged>((event, emit) async {
      String? initTheme = GetInitialTheme().getTheme();
      AppTheme themeData = getInittheme(initTheme ?? 'AppTheme.orange');
      ThemeData? getSavedTheme =
          appThemeData[themeData];
      final prefs = await SharedPreferences.getInstance();
      if (event.themeM == ThemeMode.light) {
        prefs.setString('themeMode', 'ThemeMode.light');
      } else {
        prefs.setString('themeMode', 'ThemeMode.dark');
      }

      emit(ThemeState(getSavedTheme, event.themeM));
    });
    on<ThemeChanged>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();

      if (event.theme == AppTheme.Blue) {
        prefs.setString('themeNumber', 'AppTheme.Blue');
      } else if (event.theme == AppTheme.Green) {
        prefs.setString('themeNumber', 'AppTheme.Green');
      } else {
        prefs.setString('themeNumber', 'AppTheme.Ogange');
      }

      String? initThemeMode = GetInitialTheme().getThemeMode();
      ThemeMode themeMode = getThemeMode(initThemeMode);

      emit(ThemeState(appThemeData[event.theme], themeMode));
    });
  }
}
