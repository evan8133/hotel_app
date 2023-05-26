import 'package:flutter/material.dart';

enum ThemeModeType {
  light,
  dark,

}

class ThemeProvider with ChangeNotifier {
  ThemeModeType _themeMode = ThemeModeType.dark;

  ThemeModeType get themeMode => _themeMode;

  void setThemeMode(ThemeModeType themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
