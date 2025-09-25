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

  /// Open full-screen camera
  Future<void> autoOpenCamera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
      if (!status.isGranted) {
        CustomNotifier.showSnackbar(message: "Camera permission is required", isSuccess: false);
        return;
      }
    }

    // Open CameraScreen
    final file = await Get.to<File?>(() => const CameraScreen());
    if (file != null) capturedImage.value = file;
  }

  // Compress image and convert to Base64
  Future<String> _compressAndConvertImage(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) throw Exception("Failed to decode image");
    final resized = img.copyResize(image, width: 800);
    final compressedBytes = img.encodeJpg(resized, quality: 80);
    return "data:image/jpeg;base64,${base64Encode(compressedBytes)}";
  }

  // Save visit
  Future<void> saveVisit() async {
    if (capturedImage.value == null) {
      CustomNotifier.showPopup(message: "Please capture an image", isSuccess: false);
      return;
    }

    isLoading.value = true;
    try {
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
        CustomNotifier.showPopup(message: "Visit saved successfully", isSuccess: true);
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoutes.dashBoard);
      } else {
        CustomNotifier.showPopup(message: response.message, isSuccess: false);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
