import 'package:flutter/material.dart';
import 'app_themes.dart';

enum AppThemeMode { darkMode, sentinelDark }

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _mode = AppThemeMode.darkMode;

  AppThemeMode get mode => _mode;
  ThemeData get theme =>
      _mode == AppThemeMode.darkMode ? darkModeTheme : sentinelDarkTheme;
  String get label =>
      _mode == AppThemeMode.darkMode ? 'Dark Mode' : 'Sentinel Dark';
  String get otherLabel =>
      _mode == AppThemeMode.darkMode ? 'Try Sentinel' : 'Try Dark Mode';

  void setTheme(AppThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void toggle() {
    _mode = _mode == AppThemeMode.darkMode
        ? AppThemeMode.sentinelDark
        : AppThemeMode.darkMode;
    notifyListeners();
  }
}
