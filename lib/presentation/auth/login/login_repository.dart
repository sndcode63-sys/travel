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
    final response = await _apiServices.post<LoginModels>(
      ApiConstants1.login,
          (json) => LoginModels.fromJson(json),
      data: {
        "username": username,
        "password": password,
      },
    );

    //  AFTER  LOGIN TOKEN SAVE
    final storage = StorageServices.to;
    if ((response.data?.authorizationToken ?? "").isNotEmpty) {
      storage.setAuthorizationToken(response.data!.authorizationToken!);
    }
    if ((response.data?.uniqueKey ?? "").isNotEmpty) {
      storage.setUniqueKey(response.data!.uniqueKey!);
    }

    return response;
  }
}



