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
    return await _apiServices.post<OtpModles>(
      ApiConstants1.checkAuth,
          (json) => OtpModles.fromJson(json),
      data: {
        "username": email,
        "type": type,
        "code": code,
      },
    );
  }

  /// Resend OTP
  static Future<OtpModles> resendOtp({
    required String email,
    String type = "Forgot Password",
  }) async {
    return await _apiServices.post<OtpModles>(
      ApiConstants1.auth,
          (json) => OtpModles.fromJson(json),
      data: {
        "email": email,
        "type": type,
      },
    );
  }
}

