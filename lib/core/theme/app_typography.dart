import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppTypography {
  static bool _isArabic(BuildContext context) =>
      context.locale.languageCode == 'ar';

  static TextStyle screenTitle(BuildContext context) => _isArabic(context)
      ? GoogleFonts.lalezar(
          fontSize: 42.sp,
          color: Theme.of(context).colorScheme.onSurface,
        )
      : GoogleFonts.russoOne(
          fontSize: 42.sp,
          color: Theme.of(context).colorScheme.onSurface,
        );

  static TextStyle sectionTitle(BuildContext context) => _isArabic(context)
      ? GoogleFonts.lalezar(
          fontSize: 20.sp,
          color: Theme.of(context).colorScheme.onSurface,
        )
      : GoogleFonts.russoOne(
          fontSize: 20.sp,
          color: Theme.of(context).colorScheme.onSurface,
        );

  static TextStyle cardTitle(BuildContext context) => _isArabic(context)
      ? GoogleFonts.lalezar(
          fontSize: 16.sp,
          color: Theme.of(context).colorScheme.onSurface,
        )
      : GoogleFonts.russoOne(
          fontSize: 16.sp,
          color: Theme.of(context).colorScheme.onSurface,
        );

  // ── Body Text (Cairo بالعربي / Russo One للإنجليزي) ─────────
  static TextStyle bodyMedium(BuildContext context) => _isArabic(context)
      ? GoogleFonts.cairo(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          height: 1.6,
          color: Theme.of(context).colorScheme.onSurface,
        )
      : GoogleFonts.russoOne(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: Theme.of(context).colorScheme.onSurface,
        );

  static TextStyle bodySmall(BuildContext context) => _isArabic(context)
      ? GoogleFonts.cairo(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: Theme.of(context).colorScheme.onSurface,
        )
      : GoogleFonts.russoOne(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.onSurface,
        );

  static TextStyle muted(BuildContext context) => _isArabic(context)
      ? GoogleFonts.cairo(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.darkTextMuted,
        )
      : GoogleFonts.russoOne(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.darkTextMuted,
        );

  static TextStyle questionText(BuildContext context) => _isArabic(context)
      ? GoogleFonts.cairo(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          height: 1.6,
          color: Theme.of(context).colorScheme.onSurface,
        )
      : GoogleFonts.russoOne(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Theme.of(context).colorScheme.onSurface,
        );

  // ── Numbers & Game Labels (Russo One ثابت للكل) ────────────
  static TextStyle gameLabel(BuildContext context) => GoogleFonts.russoOne(
    fontSize: 10.sp,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle username(BuildContext context) => GoogleFonts.russoOne(
    fontSize: 12.sp,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle statNumber(BuildContext context) => GoogleFonts.russoOne(
    fontSize: 24.sp,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle countdown(BuildContext context) =>
      GoogleFonts.russoOne(fontSize: 48.sp, color: AppColors.accent);

  static TextStyle xpLabel(BuildContext context) =>
      GoogleFonts.russoOne(fontSize: 14.sp, color: AppColors.accent);

  static TextStyle screenSubtitle(BuildContext context) => GoogleFonts.russoOne(
    fontSize: 10.sp,
    letterSpacing: 1.2,
    color: AppColors.accent,
  );
}
