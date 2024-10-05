import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strick_app/Keys/storage_keys.dart';
import 'package:strick_app/Theme/Theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  late SharedPreferences preferences;

  set themeData(ThemeData themeData) {
    _themeData = themeData;

    preferences.setString(themeKey, themeData == lightMode ? 'light' : 'dark');

    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  init() async {
    preferences = await SharedPreferences.getInstance();
    String? theme = preferences.getString(themeKey);

    if (theme == 'light') {
      themeData = lightMode;
    } else {
      themeData = darkMode;
    }

    notifyListeners();
  }
}
