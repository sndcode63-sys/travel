import 'dart:io';
import 'package:dio/dio.dart';
import 'package:travell_booking_app/core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/vehicle/add_vehicle.dart';
import '../../../models/vehicle/brand_name.dart';
import '../../../models/vehicle/update_vehicle_model.dart';


class UpdateVehicleRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;
  Future<UpdateVehicleModel> updateVehicle(Map<String, dynamic> data) async {
    return await _apiServices.post<UpdateVehicleModel>(
      ApiConstants1.updateVehicleData,
          (json) => UpdateVehicleModel.fromJson(json),
      data: data,
    );
  }



  // Fetch brands by vehicle type
  Future<List<BrandName>> getBrandsByVehicleType(String vehicleType) async {
    _cancelToken = CancelToken();

    return await _apiServices.getList<BrandName>(
      "${ApiConstants1.brandNameVehicle}?vehicle_type=$vehicleType",
          (json) => BrandName.fromJson(json),
      cancelToken: _cancelToken,
    );
  }

  void cancelRequest() {
    _cancelToken?.cancel();
  }
}
