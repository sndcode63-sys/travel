import 'package:flutter/material.dart';

import '../../constents/colors.dart';
import '../../sizes.dart';

class UCardTheme {
  UCardTheme._();

  static final lightCardTheme = CardThemeData(
    color: UColors.light, // Card background
    elevation: 4,
    shadowColor: UColors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(USizes.borderRadiusLg),
      side: BorderSide(color: UColors.light),
    ),
    margin: const EdgeInsets.all(8),
  );

  static final darkCardTheme = CardThemeData(
    color: UColors.darkGrey, // Dark card background
    elevation: 4,
    shadowColor: UColors.black.withOpacity(0.3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(USizes.borderRadiusLg),
      side: const BorderSide(color: UColors.primary),
    ),
    margin: const EdgeInsets.all(8),
  );
}

// class UContainerTheme {
//   UContainerTheme._();
//
//   static final lightContainerDecoration = BoxDecoration(
//     color: UColors.light,
//     borderRadius: BorderRadius.circular(USizes.containerRadius),
//     border: Border.all(color: UColors.borderLight),
//     boxShadow: [
//       BoxShadow(
//         color: UColors.greyLight.withOpacity(0.3),
//         blurRadius: 4,
//         offset: const Offset(0, 2),
//       ),
//     ],
//   );
//
//   static final darkContainerDecoration = BoxDecoration(
//     color: UColors.darkGrey,
//     borderRadius: BorderRadius.circular(USizes.containerRadius),
//     border: Border.all(color: UColors.primary),
//     boxShadow: [
//       BoxShadow(
//         color: UColors.black.withOpacity(0.3),
//         blurRadius: 4,
//         offset: const Offset(0, 2),
//       ),
//     ],
//   );
// }
