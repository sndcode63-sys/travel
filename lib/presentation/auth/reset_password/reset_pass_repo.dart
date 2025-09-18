import 'package:travell_booking_app/models/setPassword/change_password.dart';
import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
class ResetPassRepo {
  static final _apiServices = ApiServices();

  static Future<ChangePassword> resetPass({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await _apiServices.post<Map<String, dynamic>>(
      ApiConstants1.setPass,
          (json) => json as Map<String, dynamic>,
      data: {
        "username": email,
        "type": "Forgot Password",
        "otp": otp,
        "password": password,
        "confirmPassword": confirmPassword,
      },
    );

    if (response.success && response.data != null) {
      return ChangePassword.fromJson(response.data!);
    } else {
      throw Exception(response.errors ?? "Reset password failed");
    }
  }
}
