import 'package:intl/intl.dart';

/// Handles all date formatting in the app.
class DateFormatter {
  /// Format a date to `dd MMM yyyy` (e.g., 31 Aug 2025)
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Format date with time: `dd MMM yyyy, hh:mm a`
  static String formatDateTime(DateTime date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  /// Get only time (e.g., 10:45 PM)
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  /// Parse a string to DateTime safely
  static DateTime? parseDate(String? date, {String pattern = 'yyyy-MM-dd'}) {
    if (date == null || date.isEmpty) return null;
    try {
      return DateFormat(pattern).parse(date);
    } catch (_) {
      return null;
    }
  }

  /// Format ISO string to readable date
  static String fromIso(String isoDate) {
    try {
      return DateFormat('dd MMM yyyy, hh:mm a')
          .format(DateTime.parse(isoDate).toLocal());
    } catch (_) {
      return isoDate;
    }
  }
}
