import 'package:flutter/material.dart';

class AppColors {
  // Dark Mode
  static const dmBackground = Color(0xFF0A0A0A);
  static const dmSurface = Color(0xFF1A1A1A);
  static const dmBorder = Color(0xFF2A2A2A);
  static const dmTextPrimary = Color(0xFFFFFFFF);
  static const dmTextSecondary = Color(0xFF9CA3AF);

  // Sentinel Dark
  static const sdBackground = Color(0xFF0D1117);
  static const sdSurface = Color(0xFF161B22);
  static const sdBorder = Color(0x3300E5CC);
  static const sdTextPrimary = Color(0xFFFFFFFF);
  static const sdTextSecondary = Color(0xFF8B949E);

  // Shared
  static const accent = Color(0xFF00E5CC);
  static const accentGlow = Color(0x3300E5CC);
}

class AppThemeExtras extends ThemeExtension<AppThemeExtras> {
  final Color glowColor;
  final Color cardBorderColor;
  final String headerFontFamily;
  final bool scanLineOverlay;
  final double cardRadius;

  const AppThemeExtras({
    required this.glowColor,
    required this.cardBorderColor,
    required this.headerFontFamily,
    required this.scanLineOverlay,
    required this.cardRadius,
  });

  @override
  AppThemeExtras copyWith({
    Color? glowColor,
    Color? cardBorderColor,
    String? headerFontFamily,
    bool? scanLineOverlay,
    double? cardRadius,
  }) {
    return AppThemeExtras(
      glowColor: glowColor ?? this.glowColor,
      cardBorderColor: cardBorderColor ?? this.cardBorderColor,
      headerFontFamily: headerFontFamily ?? this.headerFontFamily,
      scanLineOverlay: scanLineOverlay ?? this.scanLineOverlay,
      cardRadius: cardRadius ?? this.cardRadius,
    );
  }

  @override
  AppThemeExtras lerp(covariant ThemeExtension<AppThemeExtras>? other, double t) {
    if (other is! AppThemeExtras) return this;
    return AppThemeExtras(
      glowColor: Color.lerp(glowColor, other.glowColor, t)!,
      cardBorderColor: Color.lerp(cardBorderColor, other.cardBorderColor, t)!,
      headerFontFamily: t < 0.5 ? headerFontFamily : other.headerFontFamily,
      scanLineOverlay: t < 0.5 ? scanLineOverlay : other.scanLineOverlay,
      cardRadius: cardRadius + (other.cardRadius - cardRadius) * t,
    );
  }
}

final darkModeTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.dmBackground,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.accent,
    secondary: AppColors.accent,
    surface: AppColors.dmSurface,
    onSurface: AppColors.dmTextPrimary,
  ),
  cardTheme: CardThemeData(
    color: AppColors.dmSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: AppColors.dmBorder, width: 1),
    ),
    elevation: 0,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.dmBackground,
    foregroundColor: AppColors.dmTextPrimary,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.dmSurface,
    selectedItemColor: AppColors.accent,
    unselectedItemColor: AppColors.dmTextSecondary,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: AppColors.dmTextPrimary, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(color: AppColors.dmTextPrimary, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(color: AppColors.dmTextPrimary, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(color: AppColors.dmTextPrimary, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(color: AppColors.dmTextPrimary),
    bodyLarge: TextStyle(color: AppColors.dmTextPrimary),
    bodyMedium: TextStyle(color: AppColors.dmTextSecondary),
    bodySmall: TextStyle(color: AppColors.dmTextSecondary),
    labelLarge: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(color: AppColors.dmTextSecondary, letterSpacing: 1.2),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.dmSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.dmBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.dmBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.accent),
    ),
    labelStyle: const TextStyle(color: AppColors.dmTextSecondary),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.dmBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
    ),
  ),
  extensions: const [
    AppThemeExtras(
      glowColor: Colors.transparent,
      cardBorderColor: AppColors.dmBorder,
      headerFontFamily: '',
      scanLineOverlay: false,
      cardRadius: 12,
    ),
  ],
);

final sentinelDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.sdBackground,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.accent,
    secondary: AppColors.accent,
    surface: AppColors.sdSurface,
    onSurface: AppColors.sdTextPrimary,
  ),
  cardTheme: CardThemeData(
    color: AppColors.sdSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: AppColors.sdBorder, width: 1),
    ),
    elevation: 0,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.sdBackground,
    foregroundColor: AppColors.sdTextPrimary,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.sdSurface,
    selectedItemColor: AppColors.accent,
    unselectedItemColor: AppColors.sdTextSecondary,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      color: AppColors.sdTextPrimary,
      fontWeight: FontWeight.bold,
      fontFamily: 'FiraCode',
      letterSpacing: 2,
    ),
    headlineMedium: TextStyle(
      color: AppColors.sdTextPrimary,
      fontWeight: FontWeight.bold,
      fontFamily: 'FiraCode',
      letterSpacing: 1.5,
    ),
    headlineSmall: TextStyle(
      color: AppColors.sdTextPrimary,
      fontWeight: FontWeight.w600,
      fontFamily: 'FiraCode',
      letterSpacing: 1,
    ),
    titleLarge: TextStyle(color: AppColors.sdTextPrimary, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(color: AppColors.sdTextPrimary),
    bodyLarge: TextStyle(color: AppColors.sdTextPrimary),
    bodyMedium: TextStyle(color: AppColors.sdTextSecondary),
    bodySmall: TextStyle(color: AppColors.sdTextSecondary),
    labelLarge: TextStyle(
      color: AppColors.accent,
      fontWeight: FontWeight.w600,
      fontFamily: 'FiraCode',
      letterSpacing: 1.5,
    ),
    labelSmall: TextStyle(
      color: AppColors.sdTextSecondary,
      fontFamily: 'FiraCode',
      letterSpacing: 1.5,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.sdSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.sdBorder),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.sdBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.accent),
    ),
    labelStyle: TextStyle(
      color: AppColors.sdTextSecondary,
      fontFamily: 'FiraCode',
      letterSpacing: 1.2,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.sdBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        fontFamily: 'FiraCode',
        letterSpacing: 1.5,
      ),
    ),
  ),
  extensions: const [
    AppThemeExtras(
      glowColor: AppColors.accentGlow,
      cardBorderColor: AppColors.sdBorder,
      headerFontFamily: 'FiraCode',
      scanLineOverlay: true,
      cardRadius: 8,
    ),
  ],
);
