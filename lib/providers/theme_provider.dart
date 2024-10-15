import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode mode = ThemeMode.light;

  void toggleMode() {
    if (mode == ThemeMode.light) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }

    notifyListeners();
  }
}
