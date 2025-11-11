import 'dart:io';
import 'package:dio/dio.dart';
import 'package:travell_booking_app/core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/suggestion/save_suggetion_model.dart';
import '../../../models/vehicle/add_vehicle.dart';
import '../../../models/vehicle/brand_name.dart';


class SuggestionSaveRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<SaveSuggestionModel> saveSuggestion({required SaveSuggestionModel vehicle}) async {
    return await _apiServices.post<SaveSuggestionModel>(
      ApiConstants1.saveSuggestion,
          (json) => SaveSuggestionModel.fromJson(json),
      data: vehicle.toJson(),
    );
  }


  void cancelRequest() {
    _cancelToken?.cancel();
  }
}
