import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/services/api_manager.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import 'profilepic_repository.dart';

class ProfilePicController extends GetxController {
  final picker = ImagePicker();
  Rx<File?> profileImage = Rx<File?>(null);
  RxBool isLoading = false.obs;

  // Pick image from gallery
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    } else {
      Get.snackbar('Error', 'No image selected.');
    }
  }

  // Remove selected image
  void removeImage() {
    profileImage.value = null;
  }

  // Upload profile picture
  Future<void> updateProfile() async {
    if (profileImage.value == null) {
      Get.snackbar('Error', 'Please select an image first.',backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      final File file = profileImage.value!;

      final response = await ProfileRepository.uploadProfilePic(file: file);

      isLoading.value = false;

      if (response.status == 200) {
        final bytes = await file.readAsBytes();
        final base64Image =
            "data:image/${file.path.split('.').last};base64,${base64Encode(bytes)}";

        AuthService.to.updateProfilePic(base64Image);

        profileImage.value = null;

        CustomNotifier.showPopup(
          message: response.message ?? "",
          isSuccess: true,
        );
      } else {
        CustomNotifier.showPopup(
          message: response.message ?? "",
          isSuccess: false,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Something went wrong: $e',backgroundColor: Colors.red);
    }
  }
}
