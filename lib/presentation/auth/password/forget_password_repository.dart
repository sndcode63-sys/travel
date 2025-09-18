import 'package:travell_booking_app/models/forget/forget_pass_models.dart';
import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';

class ForgetPasswordRepository {
  static final _apiServices = ApiServices();

  static Future<ForgetPassModels> requestOtp({
    required String email,
    String selectType = "email",
    String type = "Forgot Password",
    Map<String, dynamic>? extraParams,
  }) async {
    final response = await _apiServices.post<Map<String, dynamic>>(
      ApiConstants1.auth,
          (json) => json as Map<String, dynamic>,
      data: {
        "selecttype": selectType,
        "email": email,
        "type": type,
        if (extraParams != null) ...extraParams,
      },
    );

    if (response.success && response.data != null) {
      final otpData = ForgetPassModels.fromJson(response.data!);
      return otpData;
    } else {
      throw Exception(response.errors ?? "Request OTP failed");
    }
  }
}
