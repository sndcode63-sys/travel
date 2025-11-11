import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/vehicle/notify_model.dart';
import '../../../models/vehicle/vehicle_search.dart';


class RepositoryVehicleSearch {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<List<VehicleSearch>> searchUsers({
    required String searchText,
  }) async {
    _cancelToken = CancelToken();

    //  Correct body key name
    final body = {
      "searchText": searchText,
    };

    print("🔍 Sending body to API: $body");

    return await _apiServices.post<List<VehicleSearch>>(
      ApiConstants1.searchVehicleData,
          (data) {
        final List<dynamic> jsonList = data['data'] ?? [];
        print(" API RESPONSE LIST: $jsonList");
        return jsonList.map((json) => VehicleSearch.fromJson(json)).toList();
      },
      data: body,
      cancelToken: _cancelToken,
    );
  }


  // POST API
  Future<NotifyModel> saveVehicle({required NotifyModel vehicle}) async {
    return await _apiServices.post<NotifyModel>(
      ApiConstants1.notifyVehicle,
          (data) {
        if (data is String) {
          return NotifyModel.fromJson(jsonDecode(data));
        } else if (data is Map<String, dynamic>) {
          return NotifyModel.fromJson(data);
        } else {
          throw Exception("Unexpected API response type: ${data.runtimeType}");
        }
      },
      data: vehicle.toJson(),
    );
  }


  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by user");
  }
}
