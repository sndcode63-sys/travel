import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:travell_booking_app/core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../models/verification/email_verification_model.dart';
import '../../models/verification/pan_verification.dart';
import '../../models/verification/save_aadhar_model.dart';


class VerificationRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<EmailVerificationModel> verifyEmail({required EmailVerificationModel vehicle}) async {
    return await _apiServices.post<EmailVerificationModel>(
      ApiConstants1.sendVerificationCode,
          (json) => EmailVerificationModel.fromJson(json),
      data: vehicle.toJson(),
    );
  }


  Future<SaveAadharModel> verifyAadhar({required SaveAadharModel vehicle}) async {
    return await _apiServices.post<SaveAadharModel>(
      ApiConstants1.saveVerificationData,
          (json) {
        final Map<String, dynamic> data = json is String ? jsonDecode(json) : json;
        return SaveAadharModel.fromJson(data);
      },      data: vehicle.toJson(),
    );
  }

  //PAN
  Future<SavePanModel> verifyPan({required SavePanModel vehicle}) async {
    return await _apiServices.post<SavePanModel>(
      ApiConstants1.saveVerificationData,
          (json) {
        final Map<String, dynamic> data = json is String ? jsonDecode(json) : json;
        return SavePanModel.fromJson(data);
      },
      data: vehicle.toJson(),
    );
  }


  void cancelRequest() {
    _cancelToken?.cancel();
  }
}
