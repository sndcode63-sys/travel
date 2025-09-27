import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';
import '../../models/saveVisit/add_meeting_model.dart';
import '../../utlis/app_routes.dart';
import '../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../addVisit/widgets/location_services.dart';
import 'add_meeting_repository.dart';
import 'add_meeting_screen.dart';




class AddMeetingController extends GetxController {
  final numberOfUsersController = TextEditingController();
  final referenceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Rx<File?> capturedImage = Rx<File?>(null);
  final AddMeetingRepository _repository = AddMeetingRepository();
  RxBool isLoading = false.obs;

  // location
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxString currentAddress = ''.obs;
  RxBool detectingLocation = false.obs;

  RxBool locationAllowed = false.obs;

  @override
  void onInit() {
    super.onInit();
    _detectLocation();
  }

  @override
  void onClose() {
    numberOfUsersController.dispose();
    referenceController.dispose();
    super.onClose();
  }

  // Camera
  Future<void> openCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final file = await Get.to<File?>(() => const CameraScreen());
      if (file != null) {
        capturedImage.value = file;
        _detectLocation();
      }
    } else if (status.isDenied || status.isPermanentlyDenied) {
      CustomNotifier.showSnackbar(
        message: status.isPermanentlyDenied
            ? "Camera permission is permanently denied. Open settings to allow."
            : "Camera permission is required. Please allow it.",
        isSuccess: false,
      );
      if (status.isPermanentlyDenied) await openAppSettings();
    }
  }

  // Detect location
  Future<void> _detectLocation() async {
    detectingLocation.value = true;
    try {
      final result = await LocationServices.getCurrentLocationWithAddress();
      if (result != null && result['position'] != null) {
        currentPosition.value = result['position'] as Position;
        currentAddress.value = (result['address'] as String) ?? '';
        locationAllowed.value = true;
      } else {
        currentPosition.value = null;
        currentAddress.value = '';
        locationAllowed.value = false;
      }
    } catch (e) {
      currentPosition.value = null;
      currentAddress.value = '';
      locationAllowed.value = false;
    } finally {
      detectingLocation.value = false;
    }
  }

  // Validations
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

  Future<String> _compressAndConvertImage(File file) async {
    final bytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(bytes);
    if (image == null) throw Exception("Failed to decode image");
    final resized = img.copyResize(image, width: 800);
    final compressedBytes = img.encodeJpg(resized, quality: 80);
    return "data:image/jpeg;base64,${base64Encode(compressedBytes)}";
  }

  Future<void> saveForm() async {
    if (!formKey.currentState!.validate()) return;

    if (!locationAllowed.value) {
      CustomNotifier.showSnackbar(
          message: "Location is required. Please enable location.", isSuccess: false);
      return;
    }

    if (capturedImage.value == null) {
      CustomNotifier.showSnackbar(
          message: "Please capture or upload an image", isSuccess: false);
      return;
    }

    isLoading.value = true;
    try {
      final base64Image = await _compressAndConvertImage(capturedImage.value!);

      final meeting = AddMeetingModel(
        noOfUsers: numberOfUsersController.text.trim(),
        reference: referenceController.text.trim(),
        latitute: currentPosition.value?.latitude.toString(),
        longitude: currentPosition.value?.longitude.toString(),
        meetingImage: base64Image,
      );

      final response = await _repository.saveMeeting(meeting: meeting);

      CustomNotifier.showPopup(
        message: "Meeting Information Saved",
        isSuccess: true,
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (Get.isDialogOpen ?? false) Get.back();
        Get.offAllNamed(AppRoutes.dashBoard);
      });
    } catch (e) {
      CustomNotifier.showPopup(message: e.toString(), isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> requestLocationAgain() async {
    await _detectLocation();
  }
}
