// app_shadows.dart
import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppShadows {
  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static List<BoxShadow> accent = [
    BoxShadow(
      color: AppColors.accent.withValues(alpha: 0.25),
      blurRadius: 12,
      spreadRadius: 1,
      offset: Offset(0, 4),
    ),
  ];

  static List<BoxShadow> subtle = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];
}
