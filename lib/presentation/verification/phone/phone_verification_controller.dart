// ==============================================
// phone_verification_controller.dart
// ==============================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../verification_repository.dart';

class PhoneVerificationController extends GetxController {
  final phoneController = TextEditingController();
  final phoneError = ''.obs;
  final isLoading = false.obs;

  final phoneRegex = RegExp(r'^[6-9][0-9]{9}$'); // Indian phone number

  final VerificationRepository _repository = VerificationRepository();

  void validatePhone() async {
    final text = phoneController.text.trim();

    if (text.isEmpty) {
      phoneError.value = 'Phone number is required';
      return;
    } else if (!phoneRegex.hasMatch(text)) {
      phoneError.value = 'Invalid phone number (must be 10 digits)';
      return;
    } else {
      phoneError.value = '';
    }

    // API Call to send OTP
    isLoading.value = true;
    try {
      // You'll need to create a PhoneVerificationModel similar to EmailVerificationModel
      // For now, using a simple approach

      // Uncomment and modify when you have the API endpoint
      // final response = await _repository.verifyPhone(phone: text);

      // Temporary: Navigate directly to OTP screen
      // In production, wait for API response first

      CustomNotifier.showSnackbar(
          message: "OTP sent to your phone number", isSuccess: true);

      final result = await Get.toNamed(
        AppRoutes.otpVerification,
        arguments: {
          "type": "Phone",
          "identifier": phoneController.text.trim(),
          "message": "OTP sent to your phone number"
        },
      );

      if (result != null && result["verified"] == true) {
        CustomNotifier.showSnackbar(
          message: "Phone verified successfully!",
          isSuccess: true,
        );
        Get.back();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}

