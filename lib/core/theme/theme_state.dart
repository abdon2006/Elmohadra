import 'package:flutter/material.dart';

enum AppThemeMode { dark, light, system }

class ThemeState {
  final AppThemeMode themeMode;
  ThemeState({this.themeMode = AppThemeMode.system});

  bool get isDark => themeMode == AppThemeMode.dark;

  ThemeMode get flutterThemeMode => switch (themeMode) {
    AppThemeMode.dark => ThemeMode.dark,
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.system => ThemeMode.system,
  };

  ThemeState copyWith({AppThemeMode? newTheme}) =>
      ThemeState(themeMode: newTheme ?? themeMode);
}
