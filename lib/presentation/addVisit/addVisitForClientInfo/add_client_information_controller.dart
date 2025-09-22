import 'dart:convert';
import 'dart:io';
import 'dart:ui' as img;
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';

import '../../../models/saveVisit/save_visit_conte.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
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

  /// Open camera
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

  // Compress image and convert to Base64
  Future<String> _compressAndConvertImage(File file) async {
    final bytes = await file.readAsBytes();

    img.Image? image = img.decodeImage(bytes);
    if (image == null) throw Exception("Failed to decode image");

    img.Image resized = img.copyResize(image, width: 800);

    final compressedBytes = img.encodeJpg(resized, quality: 80);

    return "data:image/jpeg;base64,${base64Encode(compressedBytes)}";
  }

  // Save visit
  Future<void> saveVisit() async {
    if (capturedImage.value == null) {
      CustomNotifier.showPopup(
        message: "Please capture an image",
        isSuccess: false,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Compress image before sending
      final base64Image = await _compressAndConvertImage(capturedImage.value!);

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

      final response = await SaveVisitRepository().saveVisit(request);

      if (response.success) {
        CustomNotifier.showPopup(
          message: "Visit saved successfully",
          isSuccess: true,
        );

        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoutes.dashBoard);
      } else {
        CustomNotifier.showPopup(
          message: response.message,
          isSuccess: false,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}
