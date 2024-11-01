import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const sharedPreferencesKey = 'theme_mode';

  ThemeMode mode = ThemeMode.dark;

  bool get isDarkMode {
    return mode == ThemeMode.dark;
  }

  void loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    var themeMode = prefs.getString(sharedPreferencesKey);

    if (themeMode != null) {
      mode = themeMode == 'light' ? ThemeMode.light : ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }

    notifyListeners();
  }

  void setMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(sharedPreferencesKey, themeMode.name);

    mode = themeMode;

    notifyListeners();
  }

  void toggleMode() {
    if (mode == ThemeMode.light) {
      setMode(ThemeMode.dark);
    } else {
      setMode(ThemeMode.light);
    }
  }
}
