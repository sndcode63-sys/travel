import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../../utlis/constents/api_constants.dart';
import '../../utlis/logging/logger.dart';
import '../../utlis/storage/secure_cache_service.dart';
import '../../utlis/storage/secure_token_service.dart';
import 'api_client.dart';
import 'api_response.dart';
import 'network_exceptions.dart';






class ApiService {
  ApiService._();

  // Generic request method
  static Future<ApiResponse<T>> request<T>({
    required String endpoint,
    required String method, // GET, POST, PUT, PATCH, DELETE
    Map<String, dynamic>? queryParams,
    dynamic body,
    T Function(dynamic)? fromJson,
    bool isTokenRequired = true,
    bool useCache = false,
    Duration cacheDuration = const Duration(minutes: 5),
    Map<String, String>? extraHeaders,
  }) async {
    final uri = Uri.parse("${ApiClient.baseUrl}$endpoint")
        .replace(queryParameters: queryParams?.map((k, v) => MapEntry(k, "$v")));

    final cacheKey = _cacheKey(method, uri);

    int attempt = 0;
    http.Response response;

    while (true) {
      attempt++;
      try {
        final headers = await ApiClient.getHeaders(
          isTokenRequired: isTokenRequired,
          extra: extraHeaders,
        );

        Logger.info("API REQUEST", {
          "method": method,
          "url": uri.toString(),
          "headers": headers,
          "body": body,
        });

        response = await _dispatch(method, uri, headers, body)
            .timeout(ApiConstants.requestTimeout);

        // 401 → refresh token
        if (response.statusCode == 401 && isTokenRequired) {
          final refreshed = await SecureTokenService.getValidToken();
          if (refreshed != null) {
            final retryHeaders = await ApiClient.getHeaders(
              isTokenRequired: true,
              extra: extraHeaders,
            );
            response = await _dispatch(method, uri, retryHeaders, body)
                .timeout(ApiConstants.requestTimeout);
          }
        }

        // Parse response
        dynamic parsedData;
        try {
          parsedData = jsonDecode(response.body);
        } catch (_) {
          parsedData = response.body;
        }

        Logger.success("API RESPONSE", {
          "statusCode": response.statusCode,
          "body": parsedData,
        });

        if (response.statusCode == 200 || response.statusCode == 201) {
          return ApiResponse.success(fromJson != null ? fromJson(parsedData) : parsedData);
        }

        // Handle non-success
        final err = NetworkExceptions.handleResponse(response);
        if (_isRetriableStatus(response.statusCode) &&
            attempt <= ApiConstants.maxNetworkRetries + 1) {
          await _sleepBackoff(attempt);
          continue;
        }

        return ApiResponse.failure(err);
      } catch (e) {
        Logger.error("NETWORK ERROR", e.toString());
        if (attempt <= ApiConstants.maxNetworkRetries + 1) {
          await _sleepBackoff(attempt);
          continue;
        }
        return ApiResponse.failure(NetworkExceptions.fromHttpError(e));
      }
    }
  }

  // HTTP dispatch
  static Future<http.Response> _dispatch(
      String method, Uri uri, Map<String, String> headers, dynamic body) {
    switch (method.toUpperCase()) {
      case 'GET':
        return http.get(uri, headers: headers);
      case 'POST':
        return http.post(uri, headers: headers, body: jsonEncode(body));
      case 'PUT':
        return http.put(uri, headers: headers, body: jsonEncode(body));
      case 'PATCH':
        return http.patch(uri, headers: headers, body: jsonEncode(body));
      case 'DELETE':
        return http.delete(uri,
            headers: headers, body: body != null ? jsonEncode(body) : null);
      default:
        throw ArgumentError("Unsupported method $method");
    }
  }

  // Cache key generation
  static String _cacheKey(String method, Uri uri) =>
      "CACHE:${method.toUpperCase()}:${uri.toString()}";

  static bool _isRetriableStatus(int code) =>
      code == 500 || code == 502 || code == 503 || code == 504;

  static Future<void> _sleepBackoff(int attempt) async {
    final millis = (pow(2, attempt) * 200).clamp(200, 2000).toInt();
    await Future.delayed(Duration(milliseconds: millis));
  }

  // Convenience helpers
  static Future<ApiResponse<T>> getApi<T>(
      String endpoint, {
        Map<String, dynamic>? queryParams,
        T Function(dynamic)? fromJson,
        bool isTokenRequired = true,
        bool useCache = false,
        Duration cacheDuration = const Duration(minutes: 5),
        Map<String, String>? extraHeaders,
      }) =>
      request<T>(
        endpoint: endpoint,
        method: 'GET',
        queryParams: queryParams,
        fromJson: fromJson,
        isTokenRequired: isTokenRequired,
        useCache: useCache,
        cacheDuration: cacheDuration,
        extraHeaders: extraHeaders,
      );

  static Future<ApiResponse<T>> postApi<T>(
      String endpoint, {
        dynamic body,
        T Function(dynamic)? fromJson,
        bool isTokenRequired = true,
        Map<String, String>? extraHeaders,
      }) =>
      request<T>(
        endpoint: endpoint,
        method: 'POST',
        body: body,
        fromJson: fromJson,
        isTokenRequired: isTokenRequired,
        extraHeaders: extraHeaders,
      );
}


//  Usage Example:
// final response = await ApiService.getApi<List<SchemeListData>>(
//   ApiConstants.schemeList,
//   fromJson: (json) {
//     final list = (json['data'] as List<dynamic>);
//     return list.map((e) => SchemeListData.fromJson(e)).toList();
//   },
// );
