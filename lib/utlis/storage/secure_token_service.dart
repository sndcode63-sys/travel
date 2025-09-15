import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../constents/api_constants.dart';
import 'secure_local_storage_service.dart';



class SecureTokenService {
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String uniqueKeyKey = 'unique_key';

  static int _refreshAttempts = 0;
  static Future<String?>? _ongoingRefresh; // single-flight

  /// Get valid access token, refresh if expired
  static Future<String?> getValidToken() async {
    final token = await SecureLocalStorageService().readSecure(authTokenKey);
    print("🔹 getValidToken called, token: $token");

    if (token == null || JwtDecoder.isExpired(token)) {
      print("⏳ Token expired or null, refreshing...");
      return _refreshTokenLocked();
    }
    return token;
  }

  /// Single-flight refresh to avoid multiple parallel requests
  static Future<String?> _refreshTokenLocked() {
    _ongoingRefresh ??= _refreshToken().whenComplete(() {
      print("✅ Refresh finished");
      _ongoingRefresh = null;
    });
    return _ongoingRefresh!;
  }

  /// Actual token refresh
  static Future<String?> _refreshToken() async {
    if (_refreshAttempts >= 3) {
      print("❌ Max refresh attempts reached");
      return null;
    }
    _refreshAttempts++;

    final refreshToken =
    await SecureLocalStorageService().readSecure(refreshTokenKey);
    if (refreshToken == null) {
      print("❌ No refresh token available");
      return null;
    }

    print("🔄 Attempting refresh #$_refreshAttempts with refreshToken: $refreshToken");

    try {
      final resp = await http
          .post(
        Uri.parse(ApiConstants.refreshToken),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"refreshToken": refreshToken}),
      )
          .timeout(ApiConstants.requestTimeout);

      print("📡 Refresh response status: ${resp.statusCode}, body: ${resp.body}");

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        final accessToken = data['access_token'];
        final newRefreshToken = data['refresh_token'];

        if (accessToken != null && newRefreshToken != null) {
          await saveTokens(
            accessToken: accessToken,
            refreshToken: newRefreshToken,
          );
          _refreshAttempts = 0;
          print("💾 Tokens Saved → Access: $accessToken | Refresh: $newRefreshToken");
          return accessToken;
        }
      } else if (resp.statusCode == 401 || resp.statusCode == 403) {
        print("⚠️ Refresh token invalid, clearing session...");
        await clearSession();
      }
    } catch (e) {
      print("❌ Refresh error: $e");
    }

    return null;
  }

  /// Save tokens + uniqueKey
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    String? uniqueKey,
  }) async {
    print("💾 Saving tokens → Access: $accessToken | Refresh: $refreshToken | UniqueKey: $uniqueKey");
    await SecureLocalStorageService().writeSecure(authTokenKey, accessToken);
    await SecureLocalStorageService().writeSecure(refreshTokenKey, refreshToken);

    if (uniqueKey != null && uniqueKey.isNotEmpty) {
      await SecureLocalStorageService().writeSecure(uniqueKeyKey, uniqueKey);
    }
  }

  /// Clear all tokens/session
  static Future<void> clearSession() async {
    print("🗑️ Clearing all tokens/session");
    await SecureLocalStorageService().clearSecure();
    await SecureLocalStorageService().clear();
  }

  /// Read stored access token
  static Future<String?> getAccessToken() async =>
      SecureLocalStorageService().readSecure(authTokenKey);

  /// Read stored refresh token
  static Future<String?> getRefreshToken() async =>
      SecureLocalStorageService().readSecure(refreshTokenKey);

  /// Read stored uniqueKey
  static Future<String?> getUniqueKey() async =>
      SecureLocalStorageService().readSecure(uniqueKeyKey);
}
