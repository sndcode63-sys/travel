import '../../../core/api/api_service.dart';
import '../../../models/login_models/login_models.dart';
import '../../../utlis/constents/api_constants.dart';
import '../../../utlis/storage/secure_token_service.dart';



class LoginRepository {
  LoginRepository._();

  static Future<LoginModels> login({
    required String username,
    required String password,
  }) async {
    final response = await ApiService.request<Map<String, dynamic>>(
      endpoint: ApiConstants.login,
      method: "POST",
      body: {"username": username, "password": password},
      isTokenRequired: false,
      fromJson: (json) => json as Map<String, dynamic>,
    );

    if (response.isSuccess) {
      final loginData = LoginModels.fromJson(response.data!);

      // ✅ Tokens + uniqueKey extract karo
      final accessToken = loginData.data?.authorizationToken ?? loginData.firebaseToken ?? "";
      final refreshToken = "";
      final uniqueKey = loginData.data?.uniqueKey ?? "";

      if (accessToken.isNotEmpty) {
        await SecureTokenService.saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
          uniqueKey: uniqueKey,
        );
        print("💾 Token Saved: $accessToken | 🔑 UniqueKey Saved: $uniqueKey");
      }

      return loginData;
    } else {
      throw Exception(response.errorMessage ?? "Login failed");
    }
  }
}
