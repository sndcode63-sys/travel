import 'package:travell_booking_app/models/otp/otp_modles.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';

class OtpRepository {
  static final _apiServices = ApiServices();

  /// Submit OTP
  static Future<OtpModles> submitOtp({
    required String email,
    required String code,
    String type = "Forgot Password",
  }) async {
    final response = await _apiServices.post<Map<String, dynamic>>(
      ApiConstants1.checkAuth,
          (json) => json as Map<String, dynamic>,
      data: {
        "username": email,
        "type": type,
        "code": code,
      },
    );

    if (response.success && response.data != null) {
      return OtpModles.fromJson(response.data!);
    } else {
      throw Exception(response.errors ?? "Submit OTP failed");
    }
  }

  /// Resend OTP
  static Future<OtpModles> resendOtp({
    required String email,
    String type = "Forgot Password",
  }) async {
    final response = await _apiServices.post<Map<String, dynamic>>(
      ApiConstants1.auth,
          (json) => json as Map<String, dynamic>,
      data: {
        "username": email,
        "type": type,
      },
    );

    if (response.success && response.data != null) {
      return OtpModles.fromJson(response.data!);
    } else {
      throw Exception(response.errors ?? "Resend OTP failed");
    }
  }
}
