import 'package:flutter/material.dart';

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
      fontFamily: "OpenSans", // ✅ font family added
      color: UColors.black,
    ),

    hintStyle: const TextStyle(
      fontSize: USizes.fontSizeSm,
      fontFamily: "OpenSans", // ✅ font family added
      color: UColors.black,
    ),

    errorStyle: const TextStyle(
      fontStyle: FontStyle.normal,
      fontFamily: "OpenSans", // ✅
    ),

    floatingLabelStyle: TextStyle(
      fontFamily: "OpenSans", // ✅
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
      borderSide: const BorderSide(width: 1, color: UColors.primary),
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

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    fillColor: UColors.dark,
    prefixIconColor: UColors.darkGrey,
    suffixIconColor: UColors.darkGrey,

    labelStyle: const TextStyle(
      fontSize: USizes.fontSizeMd,
      fontFamily: "OpenSans", // ✅
      color: UColors.white,
    ),

    hintStyle: const TextStyle(
      fontSize: USizes.fontSizeSm,
      fontFamily: "OpenSans", // ✅
      color: UColors.grey,
    ),

    floatingLabelStyle: TextStyle(
      fontFamily: "OpenSans", // ✅
      color: UColors.white.withValues(alpha: 0.4),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(USizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: UColors.darkGrey),
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
