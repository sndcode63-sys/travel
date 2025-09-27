import 'dart:async';
import 'dart:convert';
import 'package:travell_booking_app/models/forget/forget_pass_models.dart';
import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';

class ForgetPasswordRepository {
  static final _apiServices = ApiServices();

  static Future<ForgetPassModels> requestOtp({
    required String email,
    required String selectType,
    required String type,
  }) async {
    final response = await _apiServices.post<ForgetPassModels>(
      ApiConstants1.auth,
          (json) {
        if (json is Map<String, dynamic>) {
          return ForgetPassModels.fromJson(json);
        } else if (json is String) {
          try {
            final map = jsonDecode(json);
            return ForgetPassModels.fromJson(map);
          } catch (_) {
            return ForgetPassModels(status: 400, message: json);
          }
        } else {
          return ForgetPassModels(status: 400, message: "Invalid response");
        }
      },
      data: {
        "selecttype":"email",
        "email": email,
        "type": "Forgot Password",
      },
    );
    return response;
  }
}
