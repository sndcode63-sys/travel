
import 'dart:io';

import 'package:dio/dio.dart';
import '../../core/response_model.dart';
import '../providers/api_provider.dart';

class ApiServices {
  final ApiProvider _apiProvider = ApiProvider();

  // Generic method for single object
  Future<ApiResponse<T>> handleApiCall<T>(
      Future<Response> Function() apiCall, T Function(dynamic) fromJson) async {
    try {
      final response = await apiCall();

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

  // Generic method for list
  Future<ApiResponse<List<T>>> handleListApiCall<T>(
      Future<Response> Function() apiCall, T Function(dynamic) fromJson) async {
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
          return ApiResponse.success(<T>[]);
        }
      } else {
        return ApiResponse.error('Request failed with status : ${response.statusCode}');
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

  // ---------------- API Wrappers ----------------
  Future<ApiResponse<T>> get<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) =>
      handleApiCall(() => _apiProvider.get(
        endPoint,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ), fromJson);

  Future<ApiResponse<List<T>>> getList<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) =>
      handleListApiCall(() => _apiProvider.get(
        endPoint,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ), fromJson);

  Future<ApiResponse<T>> post<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) =>
      handleApiCall(() => _apiProvider.post(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ), fromJson);

  Future<ApiResponse<T>> put<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) =>
      handleApiCall(() => _apiProvider.put(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ), fromJson);

  Future<ApiResponse<T>> delete<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) =>
      handleApiCall(() => _apiProvider.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ), fromJson);

  Future<ApiResponse<T>> postMultipart<T>(
      String endPoint,
      T Function(dynamic) fromJson, {
        required Map<String, dynamic> data,
        File? imageFile,
        String imageFieldName = 'image',
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) async {
    final formData = FormData.fromMap(data);

    if (imageFile != null && await imageFile.exists()) {
      formData.files.add(MapEntry(
        imageFieldName,
        await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      ));
    }

    return handleApiCall(
            () => _apiProvider.postMultipart(
          endPoint,
          formData: formData,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
        ),
        fromJson);
  }
}
