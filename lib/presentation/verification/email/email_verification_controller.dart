import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/verification/email_verification_model.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../verification_repository.dart';

class EmailVerificationController extends GetxController {
  final emailController = TextEditingController();
  final emailError = RxString('');
  final isLoading = false.obs;

  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  final VerificationRepository _repository = VerificationRepository();

  void validateEmail() async {
    final text = emailController.text.trim();

    if (text.isEmpty) {
      emailError.value = 'Email is required';
      return;
    } else if (!emailRegex.hasMatch(text)) {
      emailError.value = 'Invalid email format';
      return;
    } else {
      emailError.value = '';
      await sendEmailVerification(text);
    }
  }

  Future<void> sendEmailVerification(String email) async {
    try {
      isLoading.value = true;

      final model = EmailVerificationModel(
        type: "Email Verification",
        email: email,
      );

      final response = await _repository.verifyEmail(vehicle: model);

      if (response.status == 200) {
        CustomNotifier.showSnackbar(
            message: response.message ?? "", isSuccess: true);

        // Debug: Check what we're passing
        print("📧 Navigating to OTP with:");
        print("Type: Email");
        print("Identifier: ${emailController.text.trim()}");
        print("Message: ${response.message}");

        // Navigate to OTP screen with type "Email"
        final result = await Get.toNamed(
          AppRoutes.otpVerification,
          arguments: {
            "type": "Email",
            "identifier": emailController.text.trim(),
            "message": response.message ?? ""
          },
        );

        // Handle result when user comes back
        if (result != null && result["verified"] == true) {
          CustomNotifier.showSnackbar(
            message: "Email verified successfully!",
            isSuccess: true,
          );
          Get.back(); // Go back to verification status screen
        }
      } else {
        CustomNotifier.showPopup(
            message: response.message ?? "", isSuccess: false);
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
    emailController.dispose();
    super.onClose();
  }
}