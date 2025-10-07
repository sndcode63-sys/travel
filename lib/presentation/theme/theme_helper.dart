import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_controller.dart';

class ThemeManager {
  final ThemeController themeController = Get.find();

  ThemeData get lightTheme {
    final base = FlexThemeData.light(
      scheme: FlexScheme.custom,
      primary: themeController.primaryColor.value,
      secondary: themeController.secondaryColor.value,
      appBarStyle: FlexAppBarStyle.primary,
    );

    return base.copyWith(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: themeController.primaryColor.value,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeController.primaryColor.value,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    final base = FlexThemeData.dark(
      scheme: FlexScheme.custom,
      primary: themeController.primaryColor.value,
      secondary: themeController.secondaryColor.value,
      appBarStyle: FlexAppBarStyle.primary,
    );

    return base.copyWith(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: themeController.primaryColor.value,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeController.primaryColor.value,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  ThemeMode get themeMode => themeController.themeMode.value;
}

class ThemeHelper {
  static final ThemeController _theme = Get.find<ThemeController>();

  static Color get scaffoldBackground {
    if (_theme.selectedThemeIndex.value != -1) {
      return _theme.primaryColor.value.withOpacity(0.3);
    }
    return _theme.isDark.value ? Colors.grey[900]! : Colors.grey[100]!;
  }

  static Color get containerBackground {
    if (_theme.selectedThemeIndex.value != -1) {
      return _theme.primaryColor.value.withOpacity(0.8);
    }
    return _theme.isDark.value ? Colors.grey[800]! : Colors.grey[300]!;
  }

  static Color get textColor {
    if (_theme.selectedThemeIndex.value != -1) {
      return _theme.secondaryColor.value;
    }
    return _theme.isDark.value ? Colors.white : Colors.black;
  }

  static Color get textColors {
    return _theme.isDark.value ? Colors.white : Colors.black;
  }

  static Color get bottomSheetBackground {
    if (_theme.selectedThemeIndex.value != -1) {
      return _theme.primaryColor.value.withOpacity(0.9);
    }
    return _theme.isDark.value ? Colors.grey[850]! : Colors.grey[200]!;
  }

  static Color get fabColor => _theme.primaryColor.value;
}