import 'package:flutter/material.dart';

import '../../constents/color_constants.dart';


import 'package:flutter/material.dart';

// app_text_style.dart

import 'package:flutter/material.dart';

// Assuming you have an AppColors class defined elsewhere.
// import 'package:your_app_name/app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  // -------------------- LIGHT THEME --------------------
  static const TextStyle _displayLargeLight = TextStyle(fontSize: 57, fontWeight: FontWeight.normal, color: AppColors.textPrimary);
  static const TextStyle _displayMediumLight = TextStyle(fontSize: 45, fontWeight: FontWeight.normal, color: AppColors.textPrimary);
  static const TextStyle _displaySmallLight = TextStyle(fontSize: 36, fontWeight: FontWeight.normal, color: AppColors.textPrimary);

  static const TextStyle _headlineLargeLight = TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle _headlineMediumLight = TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static const TextStyle _headlineSmallLight = TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textPrimary);

  static const TextStyle _titleLargeLight = TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle _titleMediumLight = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textPrimary);
  static const TextStyle _titleSmallLight = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary);

  static const TextStyle _bodyLargeLight = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary);
  static const TextStyle _bodyMediumLight = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textSecondary);
  static const TextStyle _bodySmallLight = TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textSecondary);

  static const TextStyle _labelLargeLight = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary);
  static const TextStyle _labelMediumLight = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary);
  static const TextStyle _labelSmallLight = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondary);

  // -------------------- DARK THEME --------------------
  static const TextStyle _displayLargeDark = TextStyle(fontSize: 57, fontWeight: FontWeight.normal, color: AppColors.kWhite);
  static const TextStyle _displayMediumDark = TextStyle(fontSize: 45, fontWeight: FontWeight.normal, color: AppColors.kWhite);
  static const TextStyle _displaySmallDark = TextStyle(fontSize: 36, fontWeight: FontWeight.normal, color: AppColors.kWhite);

  static const TextStyle _headlineLargeDark = TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.kWhite);
  static const TextStyle _headlineMediumDark = TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.kWhite);
  static const TextStyle _headlineSmallDark = TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.kWhite);

  static const TextStyle _titleLargeDark = TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.kWhite);
  static const TextStyle _titleMediumDark = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.kWhite);
  static const TextStyle _titleSmallDark = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.kWhite);

  static const TextStyle _bodyLargeDark = TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.kWhite);
  static const TextStyle _bodyMediumDark = TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.greyLight);
  static const TextStyle _bodySmallDark = TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.greyLight);

  static const TextStyle _labelLargeDark = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.kWhite);
  static const TextStyle _labelMediumDark = TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.greyLight);
  static const TextStyle _labelSmallDark = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.greyLight);

  // -------------------- GETTERS --------------------
  static TextStyle displayLarge(BuildContext context) => _brightnessCheck(context, _displayLargeLight, _displayLargeDark);
  static TextStyle displayMedium(BuildContext context) => _brightnessCheck(context, _displayMediumLight, _displayMediumDark);
  static TextStyle displaySmall(BuildContext context) => _brightnessCheck(context, _displaySmallLight, _displaySmallDark);

  static TextStyle headlineLarge(BuildContext context) => _brightnessCheck(context, _headlineLargeLight, _headlineLargeDark);
  static TextStyle headlineMedium(BuildContext context) => _brightnessCheck(context, _headlineMediumLight, _headlineMediumDark);
  static TextStyle headlineSmall(BuildContext context) => _brightnessCheck(context, _headlineSmallLight, _headlineSmallDark);

  static TextStyle titleLarge(BuildContext context) => _brightnessCheck(context, _titleLargeLight, _titleLargeDark);
  static TextStyle titleMedium(BuildContext context) => _brightnessCheck(context, _titleMediumLight, _titleMediumDark);
  static TextStyle titleSmall(BuildContext context) => _brightnessCheck(context, _titleSmallLight, _titleSmallDark);

  static TextStyle bodyLarge(BuildContext context) => _brightnessCheck(context, _bodyLargeLight, _bodyLargeDark);
  static TextStyle bodyMedium(BuildContext context) => _brightnessCheck(context, _bodyMediumLight, _bodyMediumDark);
  static TextStyle bodySmall(BuildContext context) => _brightnessCheck(context, _bodySmallLight, _bodySmallDark);

  static TextStyle labelLarge(BuildContext context) => _brightnessCheck(context, _labelLargeLight, _labelLargeDark);
  static TextStyle labelMedium(BuildContext context) => _brightnessCheck(context, _labelMediumLight, _labelMediumDark);
  static TextStyle labelSmall(BuildContext context) => _brightnessCheck(context, _labelSmallLight, _labelSmallDark);

  // -------------------- HELPER --------------------
  static TextStyle _brightnessCheck(BuildContext context, TextStyle light, TextStyle dark) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? dark : light;
  }
}