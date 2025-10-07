
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import '../providers/api_provider.dart';



class ApiServices {

  final ApiProvider _apiProvider = ApiProvider();

  // ---------------- ANSI Colors ----------------

  static const String reset = '\x1B[0m';

  static const String red = '\x1B[31m';

  static const String green = '\x1B[32m';

  static const String yellow = '\x1B[33m';

  static const String blue = '\x1B[34m';

  static const String magenta = '\x1B[35m';

  static const String cyan = '\x1B[36m';

  static const String white = '\x1B[37m';



  void _printDebug(String label, String message, {String color = cyan}) {

    final border = '=' * 50;

    print('$color\n$border\n[$label]\n$message\n$border$reset');

  }



  // ---------------- Generic API Call ----------------

  Future<T> handleApiCall<T>(

      Future<Response> Function() apiCall,

      T Function(dynamic) fromJson,

      ) async {

    try {

      final response = await apiCall();

      _printDebug('API RESPONSE', response.data.toString(), color: green);

      return fromJson(response.data);

    } catch (e, stackTrace) {

      _printDebug('API ERROR', e.toString(), color: red);

      print(stackTrace);

      rethrow;

    }

  }



  Future<List<T>> handleListApiCall<T>(

      Future<Response> Function() apiCall,

      T Function(dynamic) fromJson,

      ) async {

    try {

      final response = await apiCall();

      dynamic body = response.data;



      if (body is String) {

        try {

          body = jsonDecode(body);

        } catch (e) {

          _printDebug('JSON PARSE ERROR', e.toString(), color: yellow);

          return [];

        }

      }



      if (body is Map<String, dynamic>) {

        if (body.containsKey('data') && body['data'] is List) {

          final List<dynamic> jsonList = body['data'];

          _printDebug('API RESPONSE LIST', jsonList.toString(), color: green);

          return jsonList.map((json) => fromJson(json)).toList();

        }

      }



      return [];

    } catch (e, stackTrace) {

      _printDebug('API ERROR', e.toString(), color: red);

      print(stackTrace);

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


// Simple post
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