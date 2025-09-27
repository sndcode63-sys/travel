import 'dart:convert';
import 'dart:io';
import 'dart:ui' as img;
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';

import '../../../models/saveVisit/save_visit_conte.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../addmetting/add_meeting_screen.dart';
import 'add_client_repository.dart';

class AddClientInformationController extends GetxController {
  Rx<File?> capturedImage = Rx<File?>(null);
  late final Map<String, dynamic> args;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments ?? {};
    print("⬅ Received args in AddClientInformationScreen: $args");
  }

  Future<void> openCamera() async {
    for (int i = 0; i < 3; i++) {
      var status = await Permission.camera.request();

      if (status.isGranted) {
        final file = await Get.to<File?>(() => const CameraScreen());
        if (file != null) capturedImage.value = file;
        return;
      } else if (status.isDenied) {
        CustomNotifier.showSnackbar(
          message: "Camera permission is required. Please allow it.",
          isSuccess: false,
        );
        return;
      } else if (status.isPermanentlyDenied) {
        CustomNotifier.showSnackbar(
          message: "Camera permission is permanently denied. Open settings to allow.",
          isSuccess: false,
        );
        await openAppSettings();
        return;
      }
    }
  }

  Future<String> _compressAndConvertImage(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) throw Exception("Failed to decode image");
    final resized = img.copyResize(image, width: 800);
    final compressedBytes = img.encodeJpg(resized, quality: 80);
    return "data:image/jpeg;base64,${base64Encode(compressedBytes)}";
  }

  Future<void> saveVisit() async {
    if (capturedImage.value == null) {
      CustomNotifier.showPopup(
        message: "Please capture an image",
        isSuccess: false,
      );
      return;
    }

    isLoading.value = true;

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

    try {
      final response = await SaveVisitRepository().saveVisit(request);

      // Response may or may not have success/message keys
      final resJson = response.toJson();

      if ((resJson['status'] ?? 200) == 200) {
        CustomNotifier.showPopup(
          message: resJson['message'] ?? "Visit saved successfully",
          isSuccess: true,
        );
        await Future.delayed(const Duration(seconds: 1));
        if (Get.isDialogOpen ?? false) Get.back();
        Get.offAllNamed(AppRoutes.dashBoard);
      } else {
        CustomNotifier.showPopup(
          message: resJson['message'] ?? "Failed to save visit",
          isSuccess: false,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }
}
