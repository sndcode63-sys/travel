
import '../../utlis/constents/api_constants.dart';
import '../../utlis/storage/secure_token_service.dart';


class ApiClient {
  ApiClient._();

  static const String baseUrl = ApiConstants.baseUrl;

  static const Map<String, String> _baseHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "User-Agent": "YourApp/1.0 (Flutter)"
  };

  static Future<Map<String, String>> getHeaders({
    bool isTokenRequired = true,
    Map<String, String>? extra,
  }) async {
    final h = {..._baseHeaders, if (extra != null) ...extra};

    if (isTokenRequired) {
      final token = await SecureTokenService.getValidToken();
      final uniqueKey = await SecureTokenService.getUniqueKey();

      if (uniqueKey != null) h["authorization"] = "Bearer $uniqueKey";
      if (token != null) h["basicauthorizationkey"] = token;
    }

    return h;
  }
}
