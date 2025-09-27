
import 'dart:io';

import 'package:dio/dio.dart';
import '../../core/response_model.dart';
import '../providers/api_provider.dart';

class ApiServices {
  final ApiProvider _apiProvider = ApiProvider();

  Future<T> handleApiCall<T>(
      Future<Response> Function() apiCall,
      T Function(dynamic) fromJson,
      ) async {
    try {
      final response = await apiCall();
      return fromJson(response.data);
    } catch (e) {
      rethrow; // error controller में handle करना होगा
    }
  }

  // List response
  Future<List<T>> handleListApiCall<T>(
      Future<Response> Function() apiCall,
      T Function(dynamic) fromJson,
      ) async {
    try {
      final response = await apiCall();
      final body = response.data;

      if (body is Map<String, dynamic> && body['data'] is List) {
        final List<dynamic> jsonList = body['data'];
        return jsonList.map((json) => fromJson(json)).toList();
      } else if (body is List) {
        // कभी server direct List देता है
        return body.map((json) => fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  // ---------------- API Wrappers ----------------
  Future<T> get<T>(
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

  Future<List<T>> getList<T>(
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

  Future<T> post<T>(
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

  Future<T> put<T>(
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

  Future<T> delete<T>(
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

  Future<T> postMultipart<T>(
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
