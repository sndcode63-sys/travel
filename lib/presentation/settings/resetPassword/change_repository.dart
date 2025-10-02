import 'package:travell_booking_app/models/setPassword/change.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';

class ChangeRepository {
  static final _apiServices = ApiServices();

  static Future<Change> changePass({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    return await _apiServices.post<Change>(
      ApiConstants1.changePassword,
          (json) => Change.fromJson(json),
      data: {
        "oldpassword": oldPassword,
        "password": password,
        "confirmPassword": confirmPassword,
      },
    );
  }
}
