import 'secure_local_storage_service.dart';

class SecureCacheService {
  /// Save JSON-serializable [data] with expiry.
  static Future<void> save(String key, dynamic data, Duration expiry) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await SecureLocalStorageService().write(key, {
      'data': data,
      'timestamp': now,
      'expiry': expiry.inMilliseconds,
    });
  }

  /// Get cached data if not expired; else returns null.
  static dynamic get(String key) {
    final cached = SecureLocalStorageService().read(key);
    if (cached == null) return null;

    final now = DateTime.now().millisecondsSinceEpoch;
    final timestamp = cached['timestamp'] as int;
    final expiry = cached['expiry'] as int;

    if (now - timestamp > expiry) {
      SecureLocalStorageService().delete(key);
      return null;
    }
    return cached['data'];
  }

  static Future<void> clear(String key) async =>
      SecureLocalStorageService().delete(key);
}
