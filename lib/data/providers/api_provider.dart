import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';

import '../../core/constants/api_constants.dart';
import '../services/storage_services.dart';

class ApiProvider {
  static ApiProvider? _instance;
  late Dio _dio;
  final _storageService = getx.Get.find<StorageServices>();

  ApiProvider._internal() {
    _dio = Dio();
    _initializeInterceptors();
  }

  factory ApiProvider() {
    _instance ??= ApiProvider._internal();
    return _instance!;
  }

  void _initializeInterceptors() {
    _dio.options = BaseOptions(
      baseUrl: ApiConstants1.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConstants1.connectTimerOutsMs),
      receiveTimeout: Duration(milliseconds: ApiConstants1.receiveTimerOutsMs),
      sendTimeout: Duration(milliseconds: ApiConstants1.sendTimerOutsMs),
      headers: {
        'Content-Type': ApiConstants1.contentType,
        'Accept': ApiConstants1.contentType,
      },
    );

    // 🔹 Request Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // --- Add tokens from storage ---
          final uniqueKey = _storageService.getUniqueKey();
          final authToken = _storageService.getAuthorizationToken();

          if (uniqueKey != null) {
            options.headers["authorization"] = "Bearer $uniqueKey";
          }
          if (authToken != null) {
            options.headers["basicauthorizationkey"] = authToken;
          }


          // --- Add language headers ---
          final language = _storageService.getLanguage() ?? 'en';
          options.headers[ApiConstants1.acceptLanguage] = language;

          // --- Connectivity check ---
          final connectivity = await Connectivity().checkConnectivity();
          if (connectivity == ConnectivityResult.none) {
            throw DioException(
              requestOptions: options,
              error: "No Internet connection",
              type: DioExceptionType.connectionError,
            );
          }

          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _handleTokenExpiration();
          }
          handler.next(error);
        },
      ),
    );

    // 🔹 Logger Interceptor (only for debug mode)
    if (getx.Get.isLogEnable) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }
  }

  Future<void> _handleTokenExpiration() async {
    _storageService.removeUniqueKey();
    _storageService.removeAuthorizationToken();
    getx.Get.offAllNamed(AppRoutes.login);
  }

  // -----------------------------
  // Generic API Methods
  // -----------------------------
  Future<Response> postMultipart(
      String path, {
        required FormData formData,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) async {
    try {
      return await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(
          contentType: 'multipart/form-data',
        ),
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }


  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  // -----------------------------
  // Error Handling
  // -----------------------------
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Exception('Connection timeout');
        case DioExceptionType.sendTimeout:
          return Exception('Send timeout');
        case DioExceptionType.receiveTimeout:
          return Exception('Receive timeout');
        case DioExceptionType.badResponse:
          return Exception(_handleStatusCode(error.response?.statusCode));
        case DioExceptionType.cancel:
          return Exception('Request cancelled');
        case DioExceptionType.unknown:
          return Exception('Unknown error detected');
        default:
          return Exception('Something went wrong!');
      }
    }
    return Exception('Unexpected error');
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 409:
        return 'Conflict';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service Unavailable';
      default:
        return 'Something went wrong';
    }
  }
}
