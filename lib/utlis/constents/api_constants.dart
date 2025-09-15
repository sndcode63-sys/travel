class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "https://customprojectapi.glitchprobe.com/stagingapi/api/v4";
  static const String refreshToken = "$baseUrl/auth/refresh";

  static const Duration requestTimeout = Duration(seconds: 30);
  static const int maxNetworkRetries = 3;


  //Authentication endpoints
  static const String auth = "/authenticateUser";
  static const String login = "/login-authenticate";
  static const String checkAuth = "/check-authentication-code";
  static const String setPass = "/setPassword";
  static const String schemeList = "/scheme-List";
  static const String saveVisit = "/save-visit-data";


}
