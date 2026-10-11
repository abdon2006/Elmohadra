import 'package:flutter/material.dart';

abstract class AppColors {
  // ── Dark Background ───────────────────────────────────────
  static const Color darkBgPrimary = Color(0xFF0B1F44);
  static const Color darkBgSurface = Color(0xFF1B3A6B);
  static const Color darkBgMuted = Color(0xFF243447);
  static const Color darkDivider = Color(0xFF1E3057);

  // ── Dark Text ─────────────────────────────────────────────
  static const Color darkTextPrimary = Color(0xFFF8F6F2);
  static const Color darkTextSecondary = Color(0xFFB0B8C8);
  static const Color darkTextMuted = Color(0xFF6B7A99);

  // ── Light Background ──────────────────────────────────────
  static const Color lightBgPrimary = Color(0xFFF4F6FA);
  static const Color lightBgSurface = Color(0xFFFFFFFF);
  static const Color lightBgMuted = Color(0xFFE8ECF4);
  static const Color lightDivider = Color(0xFFD0D8E8);

  // ── Light Text ────────────────────────────────────────────
  static const Color lightTextPrimary = Color(0xFF0B1F44);
  static const Color lightTextSecondary = Color(0xFF3D5280);
  static const Color lightTextMuted = Color(0xFF7A8EAD);

  // ── Shared (invariant across modes) ───────────────────────
  static const Color accent = Color(0xFFFF3B3B);
  static const Color onAccent = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFFFF3B3B);
  static const Color accentMuted = Color(0xFF7A1F1F);
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF0A500);
  static const Color error = Color(0xFFFF3B3B);
  static const Color onError = Color(0xFFFFFFFF);
}
