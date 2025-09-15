import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddMeetingController extends GetxController {
  // Text controllers
  final numberOfUsersController = TextEditingController();
  final referenceController = TextEditingController();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Image
  final ImagePicker picker = ImagePicker();
  Rx<File?> capturedImage = Rx<File?>(null);

  /// Capture image
  Future<void> captureImage(bool isFront) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: isFront ? CameraDevice.front : CameraDevice.rear,
      imageQuality: 80,
    );
    if (pickedFile != null) capturedImage.value = File(pickedFile.path);
  }

  /// Pick from gallery
  Future<void> pickFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) capturedImage.value = File(pickedFile.path);
  }

  /// Auto open camera
  Future<void> autoOpenCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 80,
    );
    if (pickedFile != null) capturedImage.value = File(pickedFile.path);
  }

  // Validators
  String? validateNumberOfUsers(String? value) {
    if (value == null || value.trim().isEmpty) return "Number of Users is required";
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "Must be a number";
    if (int.parse(value) <= 0) return "Number must be greater than 0";
    return null;
  }

  String? validateReference(String? value) {
    if (value == null || value.trim().isEmpty) return "Reference is required";
    if (value.length < 3) return "Reference must be at least 3 characters";
    return null;
  }

  // Save form
  void saveForm() {
    if (formKey.currentState!.validate()) {
      if (capturedImage.value == null) {
        Get.snackbar(
          "Error",
          "Please capture or upload an image",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return;
      }

      String numberOfUsers = numberOfUsersController.text.trim();
      String reference = referenceController.text.trim();

      print("Number of Users: $numberOfUsers");
      print("Reference: $reference");
      print("Image Path: ${capturedImage.value!.path}");

      Get.snackbar(
        "Success",
        "Meeting Information Saved",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // TODO: Save data to API or database
    }
  }

  @override
  void onClose() {
    numberOfUsersController.dispose();
    referenceController.dispose();
    super.onClose();
  }
}
