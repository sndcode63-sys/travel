import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum SnackbarType { success, error, info, warning }

class SnackbarHelper {
  SnackbarHelper._();

  static void show(
      String message, {
        String title = "",
        SnackbarType type = SnackbarType.info,
        Duration? duration,
      }) {
    Color bgColor;

    switch (type) {
      case SnackbarType.success:
        bgColor = Colors.green;
        title = title.isEmpty ? "Success" : title;
        break;
      case SnackbarType.error:
        bgColor = Colors.redAccent;
        title = title.isEmpty ? "Error" : title;
        break;
      case SnackbarType.info:
        bgColor = Colors.blue;
        title = title.isEmpty ? "Info" : title;
        break;
      case SnackbarType.warning:
        bgColor = Colors.orange;
        title = title.isEmpty ? "Warning" : title;
        break;
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor,
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(12),
      duration: duration ?? const Duration(seconds: 3),
      icon: const Icon(Icons.info, color: Colors.white),
    );
  }
}

