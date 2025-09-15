import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class AddClientInformationController extends GetxController {
  final ImagePicker picker = ImagePicker();

  Rx<File?> capturedImage = Rx<File?>(null);

  /// Capture Image with front/back camera
  Future<void> captureImage(bool isFront) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice:
      isFront ? CameraDevice.front : CameraDevice.rear,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      capturedImage.value = File(pickedFile.path);
    }
  }

  /// Auto open camera (rear by default)
  Future<void> autoOpenCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front, // default front camera
      imageQuality: 80,
    );
    if (pickedFile != null) {
      capturedImage.value = File(pickedFile.path);
    }
  }

  /// Pick image from gallery
  Future<void> pickFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      capturedImage.value = File(pickedFile.path);
    }
  }
}
