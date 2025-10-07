import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  Rx<Color> primaryColor = Colors.blue.obs;
  Rx<Color> secondaryColor = Colors.white.obs;

  // ✅ Theme index store karne ke liye
  RxInt selectedThemeIndex = (-1).obs;

// ✅ Available gradient color themes
  final List<Map<String, List<Color>>> colorThemes = [
    {
      "colors": [Colors.blue, Colors.lightBlueAccent],
    },
    {
      "colors": [Colors.deepPurple, Colors.purpleAccent],
    },
    {
      "colors": [Colors.green, Colors.lightGreenAccent],
    },
    {
      "colors": [Colors.red, Colors.orangeAccent],
    },
    {
      "colors": [Colors.teal, Colors.cyanAccent],
    },
  ];


  // Theme change karne ke liye
  void changeTheme(int index) {
    final colors = colorThemes[index]["colors"]!;
    primaryColor.value = colors.first;
    secondaryColor.value = colors.last;
    selectedThemeIndex.value = index;
  }


  //  Light Mode
  void setLightMode() {
    isDark.value = false;
    themeMode.value = ThemeMode.light;
    Get.changeThemeMode(ThemeMode.light);
  }

  // ✅ Dark Mode
  void setDarkMode() {
    isDark.value = true;
    themeMode.value = ThemeMode.dark;
    Get.changeThemeMode(ThemeMode.dark);
  }

  //  System Default
  // void setSystemDefault() {
  //   final brightness =
  //       WidgetsBinding.instance.platformDispatcher.platformBrightness;
  //   isDark.value = brightness == Brightness.dark;
  //   themeMode.value = ThemeMode.system;
  //   Get.changeThemeMode(ThemeMode.system);
  // }
}
