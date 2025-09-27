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
    return await _apiServices.post<ChangePassword>(
      ApiConstants1.setPass,
          (json) => ChangePassword.fromJson(json),
      data: {
        "username": email,
        "type": "Forgot Password",
        "otp": otp,
        "password": password,
        "confirmPassword": confirmPassword,
      },
    );
  }
}
