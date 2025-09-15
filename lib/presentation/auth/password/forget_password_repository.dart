import 'package:travell_booking_app/models/forget/forget_pass_models.dart';

import '../../../core/api/api_service.dart';
import '../../../utlis/constents/api_constants.dart';

class ForgetPasswordRepository {
  ForgetPasswordRepository._();

  static Future<ForgetPassModels> requestOtp({
    required String email,
  }) async {
    final response = await ApiService.request(
      endpoint: ApiConstants.auth, // /authenticateUser
      method: "POST",
      body: {
        "selecttype": "email",          // email ya phone
        "email": email,                 // user ka email
        "type": "Forgot Password"       // fixed value
      },
      isTokenRequired: false,
    );

    if (response.isSuccess) {
      return ForgetPassModels.fromJson(response.data);
    } else {
      throw Exception(response.errorMessage ?? "Request failed");
    }
  }
}
