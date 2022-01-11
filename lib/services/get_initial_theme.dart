import 'package:shared_preferences/shared_preferences.dart';
import 'package:toddyapp/global/theme/app_themes.dart';

class GetInitialTheme {
  late AppTheme initialTheme;

  static late SharedPreferences _prefs;

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  void setTheme({required String theme}) {
    _prefs.setString('themeNumber', theme);
    print(_prefs.getString(
      'themeNumber',
    ));
  }

  String? getTheme() {
    String? themePrint  = _prefs.getString('themeNumber');
    print("INIT THEME FROM SP $themePrint");
    String? theme = _prefs.getString('themeNumber') ;
    return theme;
  }
}

AppTheme getInittheme(String? theme) {
    if (theme == 'AppTheme.Green') {
      return AppTheme.Green;
    } else if (theme == 'AppTheme.Blue') {
      return AppTheme.Blue;
    } else {
      return AppTheme.Ogange;
    }
  }
