import 'package:travell_booking_app/models/setPassword/change_password.dart';

import '../../../core/api/api_service.dart';
import '../../../utlis/constents/api_constants.dart';

class ResetPassRepo {
  ResetPassRepo._();

  static Future<ChangePassword> resetPass({
    required String email,
    required String otp,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await ApiService.request(
      endpoint: ApiConstants.setPass,
      method: "POST",
      body: {
        "username": email,
        "type": "Forgot Password",
        "otp": otp,
        "password": password,
        "confirmPassword": confirmPassword,
      },
      isTokenRequired: false,
    );

    if (response.isSuccess) {
      return ChangePassword.fromJson(response.data);
    } else {
      throw Exception(response.errorMessage ?? "Request failed");
    }
  }
}
