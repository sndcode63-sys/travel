import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/vehicle/vehicle_list.dart';


class VehicleRepositorys {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<List<VehicleList>> getVisitList({
    int page = 1,
    int pageSize = 10,
  }) async {
    _cancelToken = CancelToken();

    final queryParameters = {
      'page': page,
      'page_size': pageSize,
    };

    return await _apiServices.getList<VehicleList>(
      ApiConstants1.getVehicleData,
          (data) => VehicleList.fromJson(data),
      queryParameters: queryParameters,
      cancelToken: _cancelToken,
    );

  }


  Future<bool> deleteVehicle(String vehicleId) async {
    try {
      final data = {"vehicleid": vehicleId};
      final response = await _apiServices.post(
        ApiConstants1.deleteVehicle,
            (json) => json,
        data: data,
      );

      if (response != null && response['status'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<bool> changeVehicleStatus(String vehicleId, bool isOn) async {
    try {
      final data = {
        "vehicleid": vehicleId,
        "active": isOn ? 1 : 0,
      };

      final response = await _apiServices.post(
        ApiConstants1.changeVehicleInformation,
            (json) => json,
        data: data,
      );

      if (response != null && response['status'] == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }


  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}
