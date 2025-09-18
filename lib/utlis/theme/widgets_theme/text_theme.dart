import 'package:flutter/material.dart';

import '../../constents/colors.dart';

import 'package:flutter/material.dart';

// Make sure to import your UColors class

class UTextTheme {
  UTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    titleSmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: "OpenSans",
      color: UColors.black,
    ), // Regular

    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: "OpenSans",
      color: UColors.black,
    ), // Medium

    bodyLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: "OpenSans",
      color: UColors.black,
    ), // SemiBold

    titleLarge: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      fontFamily: "OpenSans",
      color: UColors.black,
    ), // Bold
  );

  static TextTheme darkTextTheme = TextTheme(
    titleSmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: "OpenSans",
      color: UColors.white,
    ),

    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: "OpenSans",
      color: UColors.grey,
    ),

    bodyLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: "OpenSans",
      color: UColors.white,
    ),

    titleLarge: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      fontFamily: "OpenSans",
      color: UColors.white,
    ),
  );
}
