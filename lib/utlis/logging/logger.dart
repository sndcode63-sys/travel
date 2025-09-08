import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static bool enableLogging = !kReleaseMode;

  /// Log debug messages
  static void d(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    if (!enableLogging) return;
    developer.log("[DEBUG] [$tag] $message", error: error, stackTrace: stackTrace);
  }

  /// Log info messages
  static void i(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    if (!enableLogging) return;
    developer.log("[INFO] [$tag] $message", error: error, stackTrace: stackTrace);
  }

  /// Log warnings
  static void w(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    if (!enableLogging) return;
    developer.log("[WARN] [$tag] $message", error: error, stackTrace: stackTrace);
  }

  /// Log errors
  static void e(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    if (!enableLogging) return;
    developer.log("[ERROR] [$tag] $message", error: error, stackTrace: stackTrace);
  }

/// Optional: log to file/local storage
// static Future<void> logToFile(String message) async {
//   final file = await _getLogFile();
//   await file.writeAsString("$message\n", mode: FileMode.append);
// }
}
