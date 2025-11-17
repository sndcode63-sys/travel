import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/verification/pan_verification.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../profileCenter/profile_center_controller.dart';
import '../verification_repository.dart';

class PanVerificationController extends GetxController {
  final panController = TextEditingController();
  final panError = ''.obs;
  final isLoading = false.obs;

  final panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
  final VerificationRepository _repository = VerificationRepository();

  @override
  void onInit() {
    super.onInit();
    //  Load existing PAN from profile
    try {
      final profileController = Get.find<ProfileCenterController>();
      panController.text = profileController.userData.value.panNumber ?? "";
    } catch (e) {
      print("⚠️ ProfileCenterController not found");
    }
  }

  void validatePan() async {
    final text = panController.text.trim().toUpperCase();

    if (text.isEmpty) {
      panError.value = 'PAN number is required';
      return;
    } else if (!panRegex.hasMatch(text)) {
      panError.value = 'Invalid PAN format (e.g. ABCDE1234F)';
      return;
    } else {
      panError.value = '';
    }

    // API Call to send OTP
    isLoading.value = true;
    try {
      SavePanModel model = SavePanModel(
        type: "PAN Verification",
        panNumber: text,
      );

      final response = await _repository.verifyPan(vehicle: model);

      // ✅ Handle "already verified" case
      if (response.status == 400 &&
          response.message?.toLowerCase().contains('already verified') == true) {

        try {
          final profileController = Get.find<ProfileCenterController>();
          profileController.updateVerificationStatus("PAN", 1);
          await profileController.fetchDataUser();

          CustomNotifier.showSnackbar(
            message: "PAN is already verified!",
            isSuccess: true,
          );

          Get.back();
        } catch (e) {
          print("⚠️ Could not update status: $e");
        }
        return;
      }

      if (response.status == 200) {
        CustomNotifier.showSnackbar(
            message: response.message ?? "", isSuccess: true);

        // Navigate to OTP screen with type "PAN"
        final result = await Get.toNamed(
          AppRoutes.otpVerification,
          arguments: {
            "type": "PAN",
            "identifier": panController.text.trim(),
            "message": response.message ?? "OTP sent to your registered mobile"
          },
        );

        // Handle result when user comes back
        if (result != null && result["verified"] == true) {
          CustomNotifier.showSnackbar(
            message: "PAN verified successfully!",
            isSuccess: true,
          );

          // ✅ Refresh ProfileCenterController
          try {
            final profileController = Get.find<ProfileCenterController>();
            await profileController.fetchDataUser();
          } catch (e) {
            print("⚠️ Could not refresh profile: $e");
          }

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
    panController.dispose();
    super.onClose();
  }
}