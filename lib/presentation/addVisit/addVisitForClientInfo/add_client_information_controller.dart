import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/saveVisit/save_visit_conte.dart';
import 'add_client_repository.dart';


class AddClientInformationController extends GetxController {
  final ImagePicker picker = ImagePicker();
  Rx<File?> capturedImage = Rx<File?>(null);


  late final Map<String, dynamic> args;
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    args = Get.arguments ?? {};
    print("⬅ Received args in AddClientInformationScreen: $args");
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> autoOpenCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      capturedImage.value = File(pickedFile.path);
    }
  }

  Future<void> saveVisit() async {
    if (capturedImage.value == null) {
      Get.snackbar(
        "Error",
        "Please capture an image",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final bytes = await capturedImage.value!.readAsBytes();
      final base64Image = "data:image/jpeg;base64,${base64Encode(bytes)}";

      final request = SaveVisitConte(
        clientFullName: args['clientName'] ?? "",
        fatherName: args['fatherName'] ?? "",
        emailAddress: args['email'] ?? "",
        mobileNumber: args['contactNo'] ?? "",
        remarks: args['remark'] ?? "",
        latitute: args['lat'] ?? "",
        longitude: args['lng'] ?? "",
        schemeName: args['schemeName'] ?? "",
        visitImage: base64Image,
      );
      print("----- $request");

      final response = await SaveVisitRepository().saveVisit(request);

      isLoading.value = false;

      if (response.success) {
        Get.snackbar(
          "Success",
          "Visit saved successfully",
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
    } catch (e) {
      isLoading.value = false;
      print("❌ Exception: $e");
      Get.snackbar(
        "Error",
        "Unexpected error occurred",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
