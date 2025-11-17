
class ApiConstants1{
  static const String baseUrl = "https://customprojectapi.glitchprobe.com/stagingapi/api/v4";
  static const String refreshToken = "$baseUrl/auth/refresh";
  static const String imagePath = "http://157.230.246.155/chartgroup/stagingadmin/public/";

  // static const String apiVersion = '/v1';
  // static const String fullBaseUrl = '$baseUrl$apiVersion';

  //Authentication endpoints
  static const String auth = "/authenticateUser";
  static const String login = "/login-authenticate";
  static const String getUserDetails = "/get-user-details";
  static const String checkAuth = "/check-authentication-code";
  static const String setPass = "/setPassword";
  static const String changePassword = "/changePassword";
  static const String schemeList = "/scheme-List";
  static const String saveVisit = "/save-visit-data";
  static const String saveMeeting = "/save-meeting-data";
  static const String getVisitList = "/get-visit-list?page_no=1&per_page=10";
  static const String selfList = "/self-Affilated-List";
  static const String allDownlineList = "/all-Affilated-List";
  static const String homeSlider = "/get-home-slider";
  static const String meeting = "/get-meeting-list?page_no=1&per_page=10";
  static const String supportDetails = "/get-Support-Details";
  static const String libraryList = "/library-scheme-List";
  static const String libraryHeadList = "/library-head-List";
  static const String libraryData = "/library-data";
  static const String updateAssociateProfile = "/updateAssociateProfileData";
  static const String getDetailsFromPinCode = "/getDetailsFromPinCode";
  static const String getBankDetailsFromIfscCode = "/getBankDetailsFromIfscCode";
  static const String getPrivacyPolicy = "/get-privacy-policy";
  static const String getUserAssociate = "/get-associate-details";
  static const String relationGetRelationModel = "/GetRelationModel";
  static const String relationGetMasterAll = "/get-all-master-details";
  static const String searchUserData = "/searchUserData";
  static const String saveInternalDispute = "$baseUrl/save-internal-dispute";
  static const String saveVehicleData = "$baseUrl/saveVehicleData";
  static const String getVehicleData = "$baseUrl/getVehicleData";
  static const String searchVehicleData = "$baseUrl/searchVehicleData";
  static const String brandNameVehicle = "$baseUrl/get-vehicle-brand";
  static const String deleteVehicle = "$baseUrl/deleteVehicleInformation";
  static const String changeVehicleInformation = "$baseUrl/changeVehicleInformation";
  static const String notifyVehicle = "$baseUrl/notify";
  static const String updateVehicleData = "$baseUrl/updateVehicleData";
  static const String saveSuggestion = "$baseUrl/save-suggestion";
  static const String getSuggestionList = "$baseUrl/get-suggestion-list";
  static const String sendVerificationCode = "$baseUrl/send-verification-code";
  static const String validateOtpCode = "$baseUrl/validate-otp-code";
  static const String saveVerificationData = "$baseUrl/save-verification-data";
  static const String saveAssociateData = "$baseUrl/save-associate-data";
  static const String associateList = "$baseUrl/get-associate-list";
  static const String getDisputeData = "$baseUrl/get-dispute-data";

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
