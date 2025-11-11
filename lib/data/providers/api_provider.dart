import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';

import '../../core/constants/api_constants.dart';
import '../services/storage_services.dart';

/// Custom Exception class
class AppException implements Exception {
  final String message;
  final int? code;

  AppException(this.message, {this.code});

  @override
  String toString() => message;
}

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
      headers: {
        'Content-Type': ApiConstants1.contentType,
        'Accept': ApiConstants1.contentType,
      },
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // --- Add tokens from storage ---
          final uniqueKey = _storageService.getUniqueKey();
          final authToken = _storageService.getAuthorizationToken();

          if (uniqueKey != null) {
            options.headers["Authorization"] = "Bearer $uniqueKey";
          }
          if (authToken != null) {
            options.headers["BasicAuthorizationkey"] = authToken;
          }

          // --- Language headers ---
          final language = _storageService.getLanguage() ?? 'en';
          options.headers[ApiConstants1.acceptLanguage] = language;

          // --- Connectivity check ---
          final connectivity = await Connectivity().checkConnectivity();
          if (connectivity == ConnectivityResult.none) {
            throw DioException(
              requestOptions: options,
              error: SocketException("No Internet connection"),
              type: DioExceptionType.connectionError,
            );
          }

          handler.next(options);
        },
        onResponse: (response, handler) async {
          // --- Check for token expired in response body ---
          if (response.data is Map<String, dynamic>) {
            final body = response.data as Map<String, dynamic>;
            if ((body['status'] == 401 || body['status'] == 404) &&
                body['message']?.toString().toLowerCase().contains("unauthorized") == true) {
              StorageServices.to.logout();
              return;
            }
          }
          handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            StorageServices.to.logout();
            return;
          }
          handler.next(error);
        },
      ),
    );

    // --- Logger Interceptor ---
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

  // ----------------------------- Generic API Methods -----------------------------
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken}) async {
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

  Future<Response> post(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken}) async {
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

  Future<Response> put(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken}) async {
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

  Future<Response> delete(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken}) async {
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

  Future<Response> postMultipart(String path,
      {required FormData formData,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken}) async {
    try {
      return await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(contentType: 'multipart/form-data'),
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw _handleError(e);
    }
  }

  // ----------------------------- Error Handling -----------------------------
  AppException _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return AppException("Connection timeout. Please try again.");
        case DioExceptionType.sendTimeout:
          return AppException("Send timeout. Please try again.");
        case DioExceptionType.receiveTimeout:
          return AppException("Receive timeout. Please try again.");
        case DioExceptionType.badResponse:
          return AppException(
            _handleStatusCode(error.response?.statusCode),
            code: error.response?.statusCode,
          );
        case DioExceptionType.cancel:
          return AppException("Request cancelled");
        case DioExceptionType.connectionError:
          if (error.error is SocketException) {
            return AppException("No Internet connection");
          }
          return AppException("Connection failed. Please check your network.");
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return AppException("No Internet connection");
          }
          return AppException("Something went wrong. Please try again.");
        case DioExceptionType.badCertificate:
          return AppException("Invalid SSL certificate. Please try again later.");
      }
    }

    if (error is SocketException) {
      return AppException("No Internet connection");
    }

    return AppException("Unexpected error: ${error.toString()}");
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
