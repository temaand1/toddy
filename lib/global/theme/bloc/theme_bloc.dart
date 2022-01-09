
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toddyapp/global/theme/app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(appThemeData[AppTheme.Ogange])) {
    on<ThemeChanged>((event, emit) {
      emit(ThemeState(appThemeData[event.theme]));
    });
  }
}
