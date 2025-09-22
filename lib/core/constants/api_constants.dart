
class ApiConstants1{
  static const String baseUrl = "https://customprojectapi.glitchprobe.com/stagingapi/api/v4";
  static const String refreshToken = "$baseUrl/auth/refresh";
  static const String imagePath = "http://157.230.246.155/chartgroup/stagingadmin/public/";

  // static const String apiVersion = '/v1';
  // static const String fullBaseUrl = '$baseUrl$apiVersion';

  //Authentication endpoints
  static const String auth = "/authenticateUser";
  static const String login = "/login-authenticate";
  static const String checkAuth = "/check-authentication-code";
  static const String setPass = "/setPassword";
  static const String schemeList = "/scheme-List";
  static const String saveVisit = "/save-visit-data";
  static const String saveMeeting = "/save-meeting-data";
  static const String getVisitList = "/get-visit-list?page_no=1&per_page=10";
  static const String selfList = "/self-Affilated-List";
  static const String allDownlineList = "/all-Affilated-List";
  static const String homeSlider = "/get-home-slider";
  static const String meeting = "/get-meeting-list?page_no=1&per_page=10";

  // Headers
  static const String contentType = 'application/json';
  static const String authorization = 'basicauthorizationkey';
  static const String uniqueKey = 'authorization';
  static const String acceptLanguage = 'Accept-Language';

  //Timeouts
  static const int connectTimerOutsMs = 15000;
  static const int receiveTimerOutsMs = 15000;
  static const int sendTimerOutsMs = 15000;
}
