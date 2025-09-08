import 'package:intl/intl.dart';

/// Handles all currency formatting in the app.
class CurrencyFormatter {
  /// Format number to currency with locale (default: INR ₹)
  static String format(double amount, {String locale = 'en_IN', String symbol = '₹'}) {
    final formatter = NumberFormat.currency(locale: locale, symbol: symbol);
    return formatter.format(amount);
  }

  /// Format without decimals (₹1,000)
  static String formatWithoutDecimal(num amount, {String locale = 'en_IN', String symbol = '₹'}) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Compact format (₹1K, ₹1.5M)
  static String compact(num amount, {String locale = 'en'}) {
    final formatter = NumberFormat.compactCurrency(locale: locale, symbol: '₹');
    return formatter.format(amount);
  }
}
