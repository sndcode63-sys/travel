import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../../utlis/constents/api_constants.dart';
import '../../utlis/storage/secure_cache_service.dart';
import '../../utlis/storage/secure_token_service.dart';
import 'api_client.dart';
import 'api_response.dart';
import 'network_exceptions.dart';


class ApiService {
  ApiService._();

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
    // bool useETag = false, // uncomment if your backend supports ETag
  }) async {
    final uri = Uri.parse("${ApiClient.baseUrl}$endpoint")
        .replace(queryParameters: queryParams?.map((k, v) => MapEntry(k, "$v")));

    final cacheKey = _cacheKey(method, uri);

    // 1) cache-first
    if (useCache) {
      final cached = SecureCacheService.get(cacheKey);
      if (cached != null) {
        return ApiResponse.success(fromJson != null ? fromJson(cached) : cached);
      }
    }

    // final cachedEtag = useETag ? SecureCacheService.get("$cacheKey:etag") as String? : null;

    // Network call with retry/backoff for transient failures
    int attempt = 0;
    http.Response response;

    while (true) {
      attempt++;
      try {
        final headers = await ApiClient.getHeaders(
          isTokenRequired: isTokenRequired,
          extra: {
            if (extraHeaders != null) ...extraHeaders,
            // if (useETag && cachedEtag != null) 'If-None-Match': cachedEtag,
          },
        );

        response = await _dispatch(method, uri, headers, body)
            .timeout(ApiConstants.requestTimeout);

        // 2) 401 → try refresh & replay once
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

        // 3) Success (200..201 / 304)
        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = jsonDecode(response.body);
          if (useCache) {
            await SecureCacheService.save(cacheKey, data, cacheDuration);
            // if (useETag) {
            //   final etag = response.headers['etag'];
            //   if (etag != null) await SecureCacheService.save("$cacheKey:etag", etag, cacheDuration);
            // }
          }
          return ApiResponse.success(fromJson != null ? fromJson(data) : data);
        }

        // Optional: If-None-Match flow (304)
        // if (useETag && response.statusCode == 304) {
        //   final cachedData = SecureCacheService.get(cacheKey);
        //   if (cachedData != null) {
        //     return ApiResponse.success(fromJson != null ? fromJson(cachedData) : cachedData);
        //   }
        // }

        // 4) Non-success → map error
        final err = NetworkExceptions.handleResponse(response);
        // For 5xx, we can retry with backoff
        if (_isRetriableStatus(response.statusCode) && attempt <= ApiConstants.maxNetworkRetries + 1) {
          await _sleepBackoff(attempt);
          continue;
        }
        return ApiResponse.failure(err);

      } catch (e) {
        // Network/format exceptions → retry if allowed
        if (attempt <= ApiConstants.maxNetworkRetries + 1) {
          await _sleepBackoff(attempt);
          continue;
        }
        return ApiResponse.failure(NetworkExceptions.fromHttpError(e));
      }
    }
  }

  static Future<http.Response> _dispatch(
      String method,
      Uri uri,
      Map<String, String> headers,
      dynamic body,
      ) {
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
      // Some APIs accept JSON body for DELETE; adjust if not needed
        return http.delete(uri, headers: headers, body: body != null ? jsonEncode(body) : null);
      default:
        throw ArgumentError("Unsupported method $method");
    }
  }

  static String _cacheKey(String method, Uri uri) => "CACHE:${method.toUpperCase()}:${uri.toString()}";

  static bool _isRetriableStatus(int code) => code == 500 || code == 502 || code == 503 || code == 504;

  static Future<void> _sleepBackoff(int attempt) async {
    final millis = (pow(2, attempt) * 200).clamp(200, 2000).toInt();
    await Future.delayed(Duration(milliseconds: millis));
  }
}
