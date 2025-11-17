// ========================= AADHAR VERIFICATION CONTROLLER =========================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/verification/save_aadhar_model.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../profileCenter/profile_center_controller.dart';
import '../verification_repository.dart';

class AdharVerificationController extends GetxController {
  final aadharController = TextEditingController();
  final aadharError = ''.obs;
  final isLoading = false.obs;

  final aadharRegex = RegExp(r'^[0-9]{12}$');
  final VerificationRepository _repository = VerificationRepository();

  @override
  void onInit() {
    super.onInit();
    //  Load existing aadhar from profile
    try {
      final profileController = Get.find<ProfileCenterController>();
      aadharController.text = profileController.userData.value.aadharNumber ?? "";
    } catch (e) {
      print("⚠️ ProfileCenterController not found");
    }
  }

  void validateAadhar() async {
    final text = aadharController.text.trim();

    if (text.isEmpty) {
      aadharError.value = 'Aadhaar number is required';
      return;
    } else if (!aadharRegex.hasMatch(text)) {
      aadharError.value = 'Invalid Aadhaar number (must be 12 digits)';
      return;
    } else {
      aadharError.value = '';
    }

    // Call API to send OTP
    isLoading.value = true;
    try {
      SaveAadharModel model = SaveAadharModel(
        type: "Aadhar Verification",
        aadharNumber: text,
      );

      final response = await _repository.verifyAadhar(vehicle: model);

      // ✅ Handle "already verified" case
      if (response.status == 400 &&
          response.message?.toLowerCase().contains('already verified') == true) {

        try {
          final profileController = Get.find<ProfileCenterController>();
          profileController.updateVerificationStatus("Aadhar", 1);
          await profileController.fetchDataUser();

          CustomNotifier.showSnackbar(
            message: "Aadhar is already verified!",
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

        // Navigate to OTP screen with type "Aadhar"
        final result = await Get.toNamed(
          AppRoutes.otpVerification,
          arguments: {
            "type": "Aadhar",
            "identifier": aadharController.text.trim(),
            "message": response.message ?? "OTP sent to your registered mobile"
          },
        );

        // Handle result when user comes back
        if (result != null && result["verified"] == true) {
          CustomNotifier.showSnackbar(
            message: "Aadhar verified successfully!",
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
    aadharController.dispose();
    super.onClose();
  }
}