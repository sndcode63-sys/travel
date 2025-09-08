import 'package:flutter/material.dart';

class SnackbarHelper {
  SnackbarHelper._();

  /// Show success snackbar
  static void showSuccess(BuildContext context, String message, {Duration? duration}) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.green,
      duration: duration,
    );
  }

  /// Show error snackbar
  static void showError(BuildContext context, String message, {Duration? duration}) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.red,
      duration: duration,
    );
  }

  /// Show info snackbar
  static void showInfo(BuildContext context, String message, {Duration? duration}) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.blue,
      duration: duration,
    );
  }

  /// Generic Snackbar function
  static void _showSnackbar(
      BuildContext context,
      String message, {
        Color backgroundColor = Colors.black87,
        Duration? duration,
      }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration ?? const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
