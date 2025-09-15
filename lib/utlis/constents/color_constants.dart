import 'package:flutter/material.dart';


// AppTheme.dart

class AppTheme {
  AppTheme._();

  /// LIGHT THEME
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: "Roboto",
    useMaterial3: true,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.background,
      surface: AppColors.kWhite, // Surface color for light theme
      error: AppColors.error,
      onPrimary: AppColors.kWhite,
      onSecondary: AppColors.kWhite,
      onBackground: AppColors.textPrimary,
      onSurface: AppColors.textPrimary, // Text/icon color on light surface
      onError: AppColors.kWhite,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textSecondary),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textSecondary),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary, // AppBar background matches primary color
      foregroundColor: AppColors.kWhite, // Text and icons on the AppBar
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.kWhite),
      iconTheme: IconThemeData(color: AppColors.kWhite),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.kWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.kWhite,
      hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.7)),
      labelStyle: const TextStyle(color: AppColors.textPrimary),
      errorStyle: const TextStyle(color: AppColors.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.textSecondary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.error, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.kWhite,
    ),
  );

  /// DARK THEME
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.kBlack,
    fontFamily: "Roboto",
    useMaterial3: true,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      background: AppColors.greyDark,
      surface: AppColors.kBlack, // Surface color for dark theme
      error: AppColors.error,
      onPrimary: AppColors.kWhite,
      onSecondary: AppColors.kBlack,
      onBackground: AppColors.kWhite,
      onSurface: AppColors.kWhite, // Text/icon color on dark surface
      onError: AppColors.kWhite,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.normal, color: AppColors.kWhite),
      displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.normal, color: AppColors.kWhite),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.normal, color: AppColors.kWhite),
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: AppColors.kWhite),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.kWhite),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.kWhite),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.kWhite),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.kWhite),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.kWhite),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.kWhite),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.greyLight),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.greyLight),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.kWhite),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.greyLight),
      labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.greyLight),
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.greyDark, // AppBar background for dark theme
      foregroundColor: AppColors.kWhite, // Text and icons on the AppBar
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.kWhite),
      iconTheme: IconThemeData(color: AppColors.kWhite),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.kBlack,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey.withAlpha(76),
      hintStyle: TextStyle(color: AppColors.greyLight),
      labelStyle: const TextStyle(color: AppColors.kWhite),
      errorStyle: const TextStyle(color: AppColors.error),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.greyLight),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.error, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.kBlack,
    ),
  );
}

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF3F51B5);
  static const Color secondary = Color(0xFF009688);
  static const Color accent = Color(0xFFFFC107);
  static const Color background = Color(0xFFF5F5F5);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Base Colors
  static const Color kWhite = Colors.white;
  static const Color kBlack = Colors.black;

  // Red Variants
  static const Color kRed = Colors.red;
  static const Color kRedLight = Color(0xFFFFCDD2);
  static const Color kRedDark = Color(0xFFB71C1C);

  // Blue Variants
  static const Color kBlue = Color(0xFF1565C0);
  static const Color kBlueLight = Color(0xFF42A5F5);
  static const Color kBlueDark = Color(0xFF0D47A1);

  // Green Variants
  static const Color kGreen = Color(0xFF2E7D32);
  static const Color kGreenLight = Color(0xFF81C784);
  static const Color kGreenDark = Color(0xFF1B5E20);

  // Grey Variants (Neutral Shades)
  static const Color greyLight = Color(0xFFf9fafb);
  static const Color grey = Color(0xFF9E9E9E);

  static const Color greyDark = Color(0xFF111827);
}