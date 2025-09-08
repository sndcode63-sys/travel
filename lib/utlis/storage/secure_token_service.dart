import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../constents/api_constants.dart';
import 'secure_local_storage_service.dart';

class SecureTokenService {
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';

  static int _refreshAttempts = 0;
  static Future<String?>? _ongoingRefresh; // single-flight

  static Future<String?> getValidToken() async {
    final token = await SecureLocalStorageService().readSecure(authTokenKey);
    if (token == null || JwtDecoder.isExpired(token)) {
      return _refreshTokenLocked();
    }
    return token;
  }

  static Future<String?> _refreshTokenLocked() {
    // If a refresh is already in progress, await the same Future
    _ongoingRefresh ??= _refreshToken().whenComplete(() => _ongoingRefresh = null);
    return _ongoingRefresh!;
  }

  static Future<String?> _refreshToken() async {
    if (_refreshAttempts >= 3) return null;
    _refreshAttempts++;

    final refreshToken =
    await SecureLocalStorageService().readSecure(refreshTokenKey);
    if (refreshToken == null) return null;

    try {
      final resp = await http
          .post(
        Uri.parse(ApiConstants.refreshToken),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"refreshToken": refreshToken}),
      )
          .timeout(ApiConstants.requestTimeout);

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
          return accessToken;
        }
      } else {
        // refresh refused; clear session on hard failure patterns if needed
        if (resp.statusCode == 401 || resp.statusCode == 403) {
          await clearSession();
        }
      }
    } catch (_) {
      // swallow; fall through to null
    }
    return null;
  }

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await SecureLocalStorageService().writeSecure(authTokenKey, accessToken);
    await SecureLocalStorageService().writeSecure(refreshTokenKey, refreshToken);
  }

  static Future<void> clearSession() async {
    await SecureLocalStorageService().clearSecure();
    await SecureLocalStorageService().clear();
  }

  static Future<String?> getAccessToken() async =>
      SecureLocalStorageService().readSecure(authTokenKey);

  static Future<String?> getRefreshToken() async =>
      SecureLocalStorageService().readSecure(refreshTokenKey);
}
