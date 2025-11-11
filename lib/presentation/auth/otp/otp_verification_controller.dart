import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../profileCenter/profile_center_controller.dart';
import 'otp_repository.dart';

class OtpVerificationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final identifierController = TextEditingController();

  var isLoading = false.obs;
  var secondsRemaining = 0.obs;
  Timer? _timer;

  RxString otpMessage = "".obs;
  RxString verificationType = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;

      identifierController.text = args["identifier"] ?? args["email"] ?? "";
      otpMessage.value = args["message"] ?? "";
      verificationType.value = args["type"] ?? "Forgot Password";

      print("🔍 OTP Controller Init:");
      print("Type: ${verificationType.value}");
      print("Identifier: ${identifierController.text}");
      print("Message: ${otpMessage.value}");
    }
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    identifierController.dispose();
    super.onClose();
  }

  String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) return "OTP is required";
    if (value.length != 6) return "OTP must be 6 digits";
    if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
      return "OTP must contain only numbers";
    }
    return null;
  }

  String get timerText {
    final minutes = (secondsRemaining.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsRemaining.value % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  String get screenTitle {
    switch (verificationType.value) {
      case "Email":
        return "Email Verification";
      case "Aadhar":
        return "Aadhar Verification";
      case "PAN":
        return "PAN Verification";
      case "Phone":
        return "Phone Verification";
      default:
        return "OTP Verification";
    }
  }

  String get screenSubtitle {
    switch (verificationType.value) {
      case "Email":
        return "Enter OTP sent to ${_maskEmail(identifierController.text)}";
      case "Aadhar":
        return "Enter OTP sent to registered mobile";
      case "PAN":
        return "Enter OTP sent to registered mobile";
      case "Phone":
        return "Enter OTP sent to ${_maskPhone(identifierController.text)}";
      default:
        return "Enter your 6 digit OTP";
    }
  }

  String _maskEmail(String email) {
    if (email.isEmpty || !email.contains('@')) return "";
    final parts = email.split('@');
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 2) return email;
    return '${name.substring(0, 2)}${"*" * (name.length - 2)}@$domain';
  }

  String _maskPhone(String phone) {
    if (phone.isEmpty || phone.length < 4) return phone;
    return '${phone.substring(0, 2)}${"*" * (phone.length - 4)}${phone.substring(phone.length - 2)}';
  }

  Future<void> onVerify() async {
    if (!formKey.currentState!.validate()) return;

    print("🚀 Verifying OTP for ${verificationType.value}");

    if (identifierController.text.trim().isEmpty) {
      CustomNotifier.showSnackbar(
        message: "Identifier is missing. Please try again.",
        isSuccess: false,
      );
      Get.back();
      return;
    }

    isLoading.value = true;
    try {
      final result = await OtpRepository.submitOtp(
        identifier: identifierController.text.trim(),
        code: otpController.text.trim(),
        type: verificationType.value,
      );

      if (result.status == 200) {
        CustomNotifier.showSnackbar(
          message: result.message ?? "OTP Verified Successfully",
        );

        // ✅ Update local verification + refresh from API
        try {
          final ProfileCenterController profileController =
          Get.find<ProfileCenterController>();

          // ✅ Mark as verified (local + cache + UI refresh)
          profileController.markAsVerified(verificationType.value);

          // ✅ Fetch updated user info from API
          await profileController.fetchDataUser();
          print("✅ User profile refreshed from API");
        } catch (e) {
          print("⚠️ Could not find ProfileCenterController: $e");
        }

        _navigateAfterVerification();
      } else {
        CustomNotifier.showSnackbar(
          message: result.message ?? "Verification failed",
          isSuccess: false,
        );
      }
    } catch (e) {
      CustomNotifier.showSnackbar(
        message: e.toString(),
        isSuccess: false,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateAfterVerification() {
    switch (verificationType.value) {
      case "Email":
      case "Aadhar":
      case "PAN":
      case "Phone":
        Get.back(result: {
          "verified": true,
          "identifier": identifierController.text,
          "type": verificationType.value
        });
        break;
      case "Forgot Password":
      default:
      // Navigate to reset password
        Get.toNamed(
          AppRoutes.resetPassword,
          arguments: {
            "email": identifierController.text.trim(),
            "otp": otpController.text.trim(),
          },
        );
        break;
    }
  }

  Future<void> onResendOtp() async {
    if (secondsRemaining.value > 0) return;

    try {
      isLoading.value = true;
      final result = await OtpRepository.resendOtp(
        identifier: identifierController.text.trim(),
        type: verificationType.value,
      );

      otpMessage.value = result.message ?? "OTP sent successfully";

      CustomNotifier.showSnackbar(
        message: result.message ?? "OTP sent successfully",
      );

      _startTimer();
    } catch (e) {
      CustomNotifier.showSnackbar(
        message: e.toString(),
        isSuccess: false,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _startTimer({int durationInSeconds = 300}) {
    secondsRemaining.value = durationInSeconds;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }
}