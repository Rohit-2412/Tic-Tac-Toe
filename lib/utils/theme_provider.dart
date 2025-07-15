import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _isDarkMode ? _darkTheme : _lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Define ThemeData for light and dark modes
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: LightColors.background,
    primaryColor: LightColors.primary,
    colorScheme: const ColorScheme.light(
      background: LightColors.background,
      primary: LightColors.primary,
      secondary: LightColors.accent,
      onBackground: LightColors.text,
      onPrimary: LightColors.text,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: LightColors.text),
      bodyMedium: TextStyle(color: LightColors.text),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DarkColors.background,
    primaryColor: DarkColors.primary,
    colorScheme: const ColorScheme.dark(
      background: DarkColors.background,
      primary: DarkColors.primary,
      secondary: DarkColors.accent,
      onBackground: DarkColors.text,
      onPrimary: DarkColors.text,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: DarkColors.text),
      bodyMedium: TextStyle(color: DarkColors.text),
    ),
  );
}
