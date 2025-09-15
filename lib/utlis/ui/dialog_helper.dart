import 'package:flutter/material.dart';

class DialogHelper {
  DialogHelper._();

  // Show simple alert dialog
  static Future<void> showAlert(
      BuildContext context, {
        required String title,
        required String message,
        String confirmText = "OK",
        VoidCallback? onConfirm,
      }) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onConfirm != null) onConfirm();
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  // Show confirmation dialog with yes/no
  static Future<bool> showConfirmation(
      BuildContext context, {
        required String title,
        required String message,
        String confirmText = "Yes",
        String cancelText = "No",
      }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
