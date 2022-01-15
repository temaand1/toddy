import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toddyapp/global/theme/app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(AppTheme initTheme) : super(ThemeState(appThemeData[initTheme])) {
    on<ThemeChanged>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      if (event.theme == AppTheme.Blue) {
        prefs.setString('themeNumber', 'AppTheme.Blue');
      } else if (event.theme == AppTheme.Green) {
        prefs.setString('themeNumber', 'AppTheme.Green');
      } else {
        prefs.setString('themeNumber', 'AppTheme.Ogange');
      }

      emit(ThemeState(appThemeData[event.theme]));
    });
  }
}
