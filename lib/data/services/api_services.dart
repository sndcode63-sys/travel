
import 'dart:io';

import 'package:dio/dio.dart';
import '../../core/response_model.dart';
import '../providers/api_provider.dart';

class ApiServices {
  final ApiProvider _apiProvider = ApiProvider();

  // generic method to handle API calls
  Future<ApiResponse<T>> handleApiCall<T>(
    Future<Response> Function() apiCall,
    T Function(dynamic) fromJson,
  ) async {
    try {
      final response = await apiCall();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = fromJson(response.data);
        return ApiResponse.success(data);
      } else {
        return ApiResponse.error(
          'Request failed with status : ${response.statusCode}',
        );
      }
    } on DioException catch (e) { 
      return ApiResponse.error(
        e.message ?? "Network error occurred",
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Unexpected error : $e');
    }
  }

  // generic method to handle List API calls
  Future<ApiResponse<List<T>>> handleListApiCall<T>(
      Future<Response> Function() apiCall,
      T Function(dynamic) fromJson,
      ) async {
    try {
      final response = await apiCall();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.data;

        if (body is Map<String, dynamic> && body['data'] is List) {
          final List<dynamic> jsonList = body['data'];
          final List<T> dataList =
          jsonList.map((json) => fromJson(json as Map<String, dynamic>)).toList();
          return ApiResponse.success(dataList);
        } else {
          return ApiResponse.success(<T>[]); // empty list if no data
        }
      } else {
        return ApiResponse.error(
          'Request failed with status : ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.message ?? "Network error occurred",
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Unexpected error : $e');
    }
  }

  // specific GET method

  Future<ApiResponse<T>> get<T>(
    String endPoint,
    T Function(dynamic) fromJson, {
    Map<String, double>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    return handleApiCall<T>(
      () => _apiProvider.get(
        endPoint,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      fromJson,
    );
  }

// specific GET method for List

  Future<ApiResponse<List<T>>> getList<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) async {
    return handleListApiCall<T>(
          () => _apiProvider.get(
        endPoint,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      fromJson,
    );
  }




// specific Post method

  Future<ApiResponse<T>> post<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) async {
    return handleApiCall<T>(
          () => _apiProvider.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      fromJson,
    );
  }

// specific Put method

  Future<ApiResponse<T>> put<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) async {
    return handleApiCall<T>(
          () => _apiProvider.put(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      fromJson,
    );
  }





  Future<ApiResponse<T>> postMultipart<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        required Map<String, dynamic> data,
        File? imageFile,
        String imageFieldName = 'image',
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) async {
    try {
      final formData = FormData.fromMap(data);

      if (imageFile != null && await imageFile.exists()) {
        formData.files.add(
          MapEntry(
            imageFieldName,
            await MultipartFile.fromFile(
              imageFile.path,
              filename: imageFile.path.split('/').last,
            ),
          ),
        );
      }

      print("📤 Multipart Request → $endPoint");
      for (var field in formData.fields) {
        print("  ${field.key}: ${field.value}");
      }
      for (var file in formData.files) {
        print("  ${file.key}: ${file.value.filename}");
      }

      final response = await _apiProvider.postMultipart(
        endPoint,
        formData: formData,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );

      print("✅ Response [${response.statusCode}] : ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse.success(fromJson(response.data));
      } else {
        return ApiResponse.error(
          'Request failed with status : ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return ApiResponse.error(
        e.message ?? "Network error occurred",
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Unexpected error : $e');
    }
  }



  // specific DELETE method

  Future<ApiResponse<T>> delete<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) async {
    return handleApiCall<T>(
          () => _apiProvider.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      fromJson,
    );
  }









}
