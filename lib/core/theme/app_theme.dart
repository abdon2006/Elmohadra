import 'package:elmohadra/core/theme/app_colors.dart';
import 'package:elmohadra/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData dark(BuildContext context) => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    dividerColor: AppColors.darkDivider,
    scaffoldBackgroundColor: AppColors.darkBgPrimary,
    canvasColor: AppColors.darkBgPrimary,
    highlightColor: Colors.transparent,
    splashColor: AppColors.accent.withValues(alpha: 0.08),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.accent,
      onPrimary: AppColors.onAccent,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onAccent,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.darkBgSurface,
      onSurface: AppColors.darkTextPrimary,
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkBgSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
      actionsIconTheme: const IconThemeData(color: AppColors.accent),
      titleTextStyle: AppTypography.screenTitle(context),
    ),
    // TODO: inputDecorationTheme — custom widget
    // TODO: bottomNavigationBarTheme — custom widget
  );

  static ThemeData light(BuildContext context) => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    dividerColor: AppColors.lightDivider,
    scaffoldBackgroundColor: AppColors.lightBgPrimary,
    canvasColor: AppColors.lightBgPrimary,
    highlightColor: Colors.transparent,
    splashColor: AppColors.accent.withValues(alpha: 0.08),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.accent,
      onPrimary: AppColors.onAccent,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onAccent,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.lightBgSurface,
      onSurface: AppColors.lightTextPrimary,
    ),
    cardTheme: CardThemeData(
      color: AppColors.lightBgSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
      actionsIconTheme: const IconThemeData(color: AppColors.accent),
      titleTextStyle: AppTypography.screenTitle(context),
    ),
    // TODO: inputDecorationTheme — custom widget
    // TODO: bottomNavigationBarTheme — custom widget
  );
}
