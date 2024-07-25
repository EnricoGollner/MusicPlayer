import 'package:flutter/material.dart';
import 'package:music_player/core/themes/light_mode.dart';
import 'package:music_player/core/themes/dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() => _themeData = isDarkMode ? lightMode : darkMode;
}