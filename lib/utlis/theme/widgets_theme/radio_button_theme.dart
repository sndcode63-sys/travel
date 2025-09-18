import 'package:flutter/material.dart';

import '../../constents/colors.dart';

import 'package:flutter/material.dart';

class URadioTheme {
  URadioTheme._();

  // Light mode
  static RadioThemeData lightRadioTheme = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return UColors.primary;
      }
      return Colors.grey.shade400;
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
        return UColors.primary.withOpacity(0.12);
      }
      if (states.contains(WidgetState.pressed)) {
        return UColors.primary.withOpacity(0.24);
      }
      return null;
    }),
    // M3 ignores splashRadius; the tap effect is handled automatically
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  // Dark mode
  static RadioThemeData darkRadioTheme = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return UColors.primary;
      }
      return Colors.grey.shade700;
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered) || states.contains(MaterialState.focused)) {
        return UColors.primary.withOpacity(0.12);
      }
      if (states.contains(WidgetState.pressed)) {
        return UColors.primary.withOpacity(0.24);
      }
      return null;
    }),
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
