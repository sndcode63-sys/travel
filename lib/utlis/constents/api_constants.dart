class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "https://api.example.com";
  static const String refreshToken = "$baseUrl/auth/refresh";

  static const Duration requestTimeout = Duration(seconds: 30);
  static const int maxNetworkRetries = 3;

  // Example endpoints
  static const String login = "/auth/login";
  static const String getUsers = "/users";
  static const String getProfile = "/profile";
}
