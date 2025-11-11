import 'package:travell_booking_app/models/otp/otp_modles.dart';
import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';

class OtpRepository {
  static final _apiServices = ApiServices();

  /// Submit OTP - Generic for all verification types
  static Future<OtpModles> submitOtp({
    required String identifier, // email/aadhar/pan
    required String code,
    required String type, // Email, Aadhar, PAN, Forgot Password
  }) async {
    String endpoint = _getVerifyEndpoint(type);

    return await _apiServices.post<OtpModles>(
      endpoint,
          (json) => OtpModles.fromJson(json),
      data: _buildVerifyData(identifier, code, type),
    );
  }

  /// Resend OTP - Generic for all verification types
  static Future<OtpModles> resendOtp({
    required String identifier,
    required String type,
  }) async {
    String endpoint = _getResendEndpoint(type);

    return await _apiServices.post<OtpModles>(
      endpoint,
          (json) => OtpModles.fromJson(json),
      data: _buildResendData(identifier, type),
    );
  }

  /// Get verify endpoint based on type
  static String _getVerifyEndpoint(String type) {
    switch (type) {
      case "Email":
        return ApiConstants1.checkAuth;
      case "Aadhar":
        return ApiConstants1.saveVerificationData;
      case "PAN":
        return ApiConstants1.saveVerificationData;
      case "Phone":
        return ApiConstants1.checkAuth;
      case "Forgot Password":
      default:
        return ApiConstants1.checkAuth;
    }
  }

  /// Get resend endpoint based on type
  static String _getResendEndpoint(String type) {
    switch (type) {
      case "Email":
        return ApiConstants1.sendVerificationCode;
      case "Aadhar":
        return ApiConstants1.sendVerificationCode;
      case "PAN":
        return ApiConstants1.sendVerificationCode;
      case "Phone":
        return ApiConstants1.sendVerificationCode;
      case "Forgot Password":
      default:
        return ApiConstants1.auth;
    }
  }

  /// Build verify request data
  static Map<String, dynamic> _buildVerifyData(
      String identifier,
      String code,
      String type,
      ) {
    switch (type) {
      case "Email":
        return {
          "username": identifier,  // Changed from "email" to "username"
          "code": code,
          "type": "Email Verification",
        };
      case "Aadhar":
        return {
          "username": identifier,  // Changed to "username"
          "code": code,
          "type": "Aadhar Verification",
        };
      case "PAN":
        return {
          "username": identifier,  // Changed to "username"
          "code": code,
          "type": "PAN Verification",
        };
      case "Phone":
        return {
          "username": identifier,  // Changed to "username"
          "code": code,
          "type": "Phone Verification",
        };
      case "Forgot Password":
      default:
        return {
          "username": identifier,
          "code": code,
          "type": "Forgot Password",
        };
    }
  }

  /// Build resend request data
  static Map<String, dynamic> _buildResendData(String identifier, String type) {
    switch (type) {
      case "Email":
        return {
          "email": identifier,
          "type": "Email Verification",
        };
      case "Aadhar":
        return {
          "aadhar_number": identifier,
          "type": "Aadhar Verification",
        };
      case "PAN":
        return {
          "pan_number": identifier,
          "type": "PAN Verification",
        };
      case "Phone":
        return {
          "phone": identifier,
          "type": "Phone Verification",
        };
      case "Forgot Password":
      default:
        return {
          "email": identifier,
          "type": "Forgot Password",
        };
    }
  }
}