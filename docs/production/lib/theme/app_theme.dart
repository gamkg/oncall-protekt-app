import 'package:flutter/material.dart';

/// On Call Protekt - Production Design Tokens
/// Approved: V1 Dark Navy + Yellow
/// Reference: https://oncallprotekt.com/app-redesign/v1

class AppColors {
  AppColors._();

  // Backgrounds
  static const background = Color(0xFF0B1121);
  static const surface = Color(0xFF1A2332);
  static const surfaceAlt = Color(0xFF1F2937);
  static const navBg = Color(0xFF111827);

  // Accent
  static const accent = Color(0xFFFACC15);
  static const accentGlow = Color(0x4DFACC15);
  static const onAccent = Color(0xFF0B1121);

  // Text
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF9CA3AF);
  static const textMuted = Color(0xFF6B7280);

  // Borders
  static const border = Color(0x1AFFFFFF);
  static const borderHover = Color(0x33FFFFFF);

  // Nav
  static const navInactive = Color(0xFF6B7280);

  // Status
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);
}

final appTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.accent,
    secondary: AppColors.accent,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    onPrimary: AppColors.onAccent,
  ),
  cardTheme: CardThemeData(
    color: AppColors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: AppColors.border, width: 1),
    ),
    elevation: 0,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
    centerTitle: true,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.navBg,
    selectedItemColor: AppColors.accent,
    unselectedItemColor: AppColors.navInactive,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      fontSize: 26,
    ),
    headlineMedium: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w700,
      fontSize: 22,
    ),
    headlineSmall: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    titleLarge: TextStyle(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    titleMedium: TextStyle(color: AppColors.textPrimary, fontSize: 15),
    bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 15),
    bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 14),
    bodySmall: TextStyle(color: AppColors.textMuted, fontSize: 12),
    labelLarge: TextStyle(
      color: AppColors.accent,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      color: AppColors.textMuted,
      fontSize: 11,
      letterSpacing: 0.5,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.accent),
    ),
    labelStyle: const TextStyle(color: AppColors.textSecondary),
    hintStyle: TextStyle(color: AppColors.textMuted.withValues(alpha: 0.5)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.onAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      elevation: 0,
      shadowColor: AppColors.accentGlow,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.accent,
      side: BorderSide(color: AppColors.accent.withValues(alpha: 0.3)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.accent,
    foregroundColor: AppColors.onAccent,
    elevation: 4,
    shape: CircleBorder(),
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.border,
    thickness: 1,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surface,
    selectedColor: AppColors.accent,
    labelStyle: const TextStyle(fontSize: 12),
    side: const BorderSide(color: AppColors.border),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
);
