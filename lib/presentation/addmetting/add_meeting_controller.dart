import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/saveVisit/add_meeting_model.dart';
import 'add_meeting_repository.dart';

class AddMeetingController extends GetxController {
  final numberOfUsersController = TextEditingController();
  final referenceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();
  Rx<File?> capturedImage = Rx<File?>(null);

  final AddMeetingRepository _repository = AddMeetingRepository();
  RxBool isLoading = false.obs;

  Future<void> autoOpenCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 80,
    );
    if (pickedFile != null) capturedImage.value = File(pickedFile.path);
  }

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

  Future<void> saveForm() async {
    if (!formKey.currentState!.validate()) return;

    if (capturedImage.value == null) {
      Get.snackbar(
        "Error",
        "Please capture or upload an image",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // Convert image to Base64
    final bytes = await capturedImage.value!.readAsBytes();
    final base64Image = "data:image/jpeg;base64,${base64Encode(bytes)}";

    final meeting = AddMeetingModel(
      noOfUsers: numberOfUsersController.text.trim(),
      reference: referenceController.text.trim(),
      latitute: "28.6139",
      longitude: "77.2090",
      meetingImage: base64Image,
    );

    isLoading.value = true;
    final response = await _repository.saveMeeting(meeting: meeting);
    isLoading.value = false;

    if (response.success) {
      Get.snackbar(
        "Success",
        "Meeting Information Saved",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    } else {
      Get.snackbar(
        "Error",
        response.message,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    numberOfUsersController.dispose();
    referenceController.dispose();
    super.onClose();
  }
}
