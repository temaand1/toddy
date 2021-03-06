part of 'theme_bloc.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged({required this.theme}) : super();
}

class ThemeModeChanged extends ThemeEvent {
  final ThemeMode themeM;

  ThemeModeChanged({required this.themeM}) : super();
}
