import 'dart:developer' as developer;

class Logger {
  Logger._();

  static void info(String tag, dynamic message) {
    print("\x1B[34m[INFO][$tag]: $message\x1B[0m"); // Blue text
  }

  static void success(String tag, dynamic message) {
    print("\x1B[32m[SUCCESS][$tag]: $message\x1B[0m"); // Green text
  }

  static void error(String tag, dynamic message) {
    print("\x1B[31m[ERROR][$tag]: $message\x1B[0m"); // Red text
  }

  static void warning(String tag, dynamic message) {
    print("\x1B[33m[WARNING][$tag]: $message\x1B[0m"); // Yellow text
  }
}
