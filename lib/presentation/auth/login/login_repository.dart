import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../data/services/storage_services.dart';
import '../../../models/login_models/login_models.dart';



class LoginRepository {
  static final _apiServices = ApiServices();

  static Future<LoginModels> login({
    required String username,
    required String password,
  }) async {
    final response = await _apiServices.post<Map<String, dynamic>>(
      ApiConstants1.login,
          (json) => json as Map<String, dynamic>,
      data: {
        "username": username,
        "password": password,
      },
    );

    if (response.success && response.data != null) {
      final loginData = LoginModels.fromJson(response.data!);

      //  AFTER  LOGIN TOKEN SAVE
      final storage = StorageServices.to;
      if ((loginData.data?.authorizationToken ?? "").isNotEmpty) {
        storage.setAuthorizationToken(loginData.data!.authorizationToken!);
      }
      if ((loginData.data?.uniqueKey ?? "").isNotEmpty) {
        storage.setUniqueKey(loginData.data!.uniqueKey!);
      }

      return loginData;
    } else {
      throw Exception(response.errors ?? "Login failed");
    }
  }
}
