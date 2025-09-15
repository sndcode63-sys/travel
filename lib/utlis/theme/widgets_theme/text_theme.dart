import 'package:flutter/material.dart';

import '../../constents/colors.dart';

import 'package:flutter/material.dart';

// Make sure to import your UColors class

class UTextTheme {
  // private constructor
  UTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(fontSize: 57, fontWeight: FontWeight.normal, color: UColors.textPrimary),
    displayMedium: const TextStyle().copyWith(fontSize: 45, fontWeight: FontWeight.normal, color: UColors.textPrimary),
    displaySmall: const TextStyle().copyWith(fontSize: 36, fontWeight: FontWeight.normal, color: UColors.textPrimary),

    headlineLarge: const TextStyle().copyWith(fontSize: 20, fontWeight: FontWeight.w600, color: UColors.textPrimary),
    headlineMedium: const TextStyle().copyWith(fontSize: 28, fontWeight: FontWeight.bold, color: UColors.textPrimary),
    headlineSmall: const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w600, color: UColors.textPrimary),

    titleLarge: const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w700, color: UColors.textPrimary),
    titleMedium: const TextStyle().copyWith(fontSize: 20, fontWeight: FontWeight.w700, color: UColors.textPrimary),
    titleSmall: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: UColors.textPrimary),

    bodyLarge: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.normal, color: UColors.textPrimary),
    bodyMedium: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.normal, color: UColors.textSecondary),
    bodySmall: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.normal, color: UColors.textSecondary),

    labelLarge: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: UColors.textPrimary),
    labelMedium: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: UColors.textSecondary),
    labelSmall: const TextStyle().copyWith(fontSize: 11, fontWeight: FontWeight.w500, color: UColors.textSecondary),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: const TextStyle().copyWith(fontSize: 57, fontWeight: FontWeight.normal, color: UColors.white),
    displayMedium: const TextStyle().copyWith(fontSize: 45, fontWeight: FontWeight.normal, color: UColors.white),
    displaySmall: const TextStyle().copyWith(fontSize: 36, fontWeight: FontWeight.normal, color: UColors.white),

    headlineLarge: const TextStyle().copyWith(fontSize: 20, fontWeight: FontWeight.w600, color: UColors.white),
    headlineMedium: const TextStyle().copyWith(fontSize: 28, fontWeight: FontWeight.bold, color: UColors.white),
    headlineSmall: const TextStyle().copyWith(fontSize: 24, fontWeight: FontWeight.w600, color: UColors.white),

    titleLarge: const TextStyle().copyWith(fontSize: 22, fontWeight: FontWeight.w600, color: UColors.white),
    titleMedium: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: UColors.white),
    titleSmall: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: UColors.white),

    bodyLarge: const TextStyle().copyWith(fontSize: 16, fontWeight: FontWeight.normal, color: UColors.white),
    bodyMedium: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.normal, color: UColors.lightGrey),
    bodySmall: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.normal, color: UColors.lightGrey),

    labelLarge: const TextStyle().copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: UColors.white),
    labelMedium: const TextStyle().copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: UColors.lightGrey),
    labelSmall: const TextStyle().copyWith(fontSize: 11, fontWeight: FontWeight.w500, color: UColors.lightGrey),
  );
}