import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constents/colors.dart';
import '../../sizes.dart';

class UTextFormFieldTheme {
  UTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    filled: true,
    fillColor: UColors.white,
    prefixIconColor: UColors.darkGrey,
    suffixIconColor: UColors.darkGrey,

    labelStyle: const TextStyle(
      fontSize: USizes.fontSizeMd,
      color: UColors.black,
    ),

    hintStyle: const TextStyle(
      fontSize: USizes.fontSizeSm,
      color: UColors.black,
    ),

    errorStyle: const TextStyle(
      fontStyle: FontStyle.normal,
    ),

    floatingLabelStyle: TextStyle(
      color: UColors.black.withValues(alpha: 0.4),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.grey),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.grey),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide:  BorderSide(width: 1.r, color: UColors.primary),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide:  BorderSide(width: 1.w, color: UColors.warning),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide:  BorderSide(width: 2.r, color: UColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    fillColor: UColors.dark,
    prefixIconColor: UColors.darkGrey,
    suffixIconColor: UColors.darkGrey,

    labelStyle: const TextStyle(
      fontSize: USizes.fontSizeMd,
      color: UColors.white,
    ),

    hintStyle: const TextStyle(
      fontSize: USizes.fontSizeSm,
      color: UColors.grey,
    ),

    floatingLabelStyle: TextStyle(
      color: UColors.white.withValues(alpha: 0.4),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide:  BorderSide(width: 1.r, color: UColors.darkGrey),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.darkGrey),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.white),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.warning),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: UColors.warning),
    ),
  );
}
