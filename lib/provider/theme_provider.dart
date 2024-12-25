import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false; // Default theme is light

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode; // Toggle the theme
    notifyListeners(); // Notify listeners to rebuild widgets
  }
}
