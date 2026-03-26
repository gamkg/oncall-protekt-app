import 'package:flutter/material.dart';

class AppColors {
  // All themes use V1 Dark Navy + Yellow palette
  // from oncallprotekt.com/app-redesign/v1

  // Backgrounds
  static const dmBackground = Color(0xFF0B1121);
  static const dmSurface = Color(0xFF1A2332);
  static const dmSurfaceAlt = Color(0xFF1F2937);
  static const dmBorder = Color(0x1AFFFFFF); // rgba(255,255,255,0.1)
  static const dmTextPrimary = Color(0xFFFFFFFF);
  static const dmTextSecondary = Color(0xFF9CA3AF);

  // Sentinel uses same navy palette with subtle yellow glow borders
  static const sdBackground = Color(0xFF0B1121);
  static const sdSurface = Color(0xFF111827);
  static const sdBorder = Color(0x4DFACC15); // rgba(250,204,21,0.3)
  static const sdTextPrimary = Color(0xFFFFFFFF);
  static const sdTextSecondary = Color(0xFF9CA3AF);

  // Shared accent - V1 Yellow
  static const accent = Color(0xFFFACC15);
  static const accentGlow = Color(0x4DFACC15); // rgba(250,204,21,0.3)
  static const onAccent = Color(0xFF0B1121);

  // V1 Mockup specific tokens (same palette, clean variant)
  static const v1Background = Color(0xFF0B1121);
  static const v1Surface = Color(0xFF1A2332);
  static const v1SurfaceAlt = Color(0xFF1F2937);
  static const v1NavBg = Color(0xFF111827);
  static const v1Border = Color(0x1AFFFFFF);
  static const v1Accent = Color(0xFFFACC15);
  static const v1AccentGlow = Color(0x4DFACC15);
  static const v1OnAccent = Color(0xFF0B1121);
  static const v1TextMuted = Color(0xFF6B7280);

  // Nav
  static const navBg = Color(0xFF111827);
  static const navInactive = Color(0xFF6B7280);

  // Status
  static const statusSuccess = Color(0xFF10B981);
  static const statusWarning = Color(0xFFF59E0B);
  static const statusDanger = Color(0xFFEF4444);
  static const statusInfo = Color(0xFF3B82F6);
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
    backgroundColor: AppColors.navBg,
    selectedItemColor: AppColors.accent,
    unselectedItemColor: AppColors.navInactive,
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
      foregroundColor: AppColors.onAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      elevation: 0,
      shadowColor: AppColors.accentGlow,
    ),
  ),
  extensions: const [
    AppThemeExtras(
      glowColor: AppColors.accentGlow,
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
    backgroundColor: AppColors.navBg,
    selectedItemColor: AppColors.accent,
    unselectedItemColor: AppColors.navInactive,
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
      foregroundColor: AppColors.onAccent,
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

