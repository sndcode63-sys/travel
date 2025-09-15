import 'package:travell_booking_app/models/otp/otp_modles.dart';

import '../../../core/api/api_service.dart';
import '../../../utlis/constents/api_constants.dart';

class OtpRepository {
  OtpRepository._();

  static Future<OtpModles> submitOtp({
    required String email,
    required String code,
  }) async {
    final response = await ApiService.request(
      endpoint: ApiConstants.checkAuth,
      method: "POST",
      body: {
        "username": email,
        "type": "Forgot Password",
        "code": code,
      },
      isTokenRequired: false,
    );

    if (response.isSuccess) {
      return OtpModles.fromJson(response.data);
    } else {
      throw Exception(response.errorMessage ?? "Request failed");
    }
  }

  static Future<OtpModles> resendOtp({
    required String email,
  }) async {
    final response = await ApiService.request(
      endpoint: ApiConstants.auth,
      method: "POST",
      body: {
        "username": email,
        "type": "Forgot Password",
      },
      isTokenRequired: false,
    );

    if (response.isSuccess) {
      return OtpModles.fromJson(response.data);
    } else {
      throw Exception(response.errorMessage ?? "Resend OTP failed");
    }
  }
}
