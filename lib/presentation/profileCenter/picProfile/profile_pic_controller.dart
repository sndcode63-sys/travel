import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePicController extends GetxController {
  final picker = ImagePicker();
  Rx<File?> profileImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    } else {
      Get.snackbar('Error', 'No image selected.');
    }
  }

  void removeImage() {
    profileImage.value = null;
  }

  Future<void> updateProfile() async {
    if (profileImage.value == null) {
      Get.snackbar('Error', 'Please select an image first.');
      return;
    }

    await Future.delayed(const Duration(seconds: 2));
    Get.snackbar('Success', 'Profile picture updated successfully!');
  }
}