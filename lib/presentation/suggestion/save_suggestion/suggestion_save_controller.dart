import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/suggestion/save_suggetion_model.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import 'suggestion_save_repository.dart';
import 'package:file_picker/file_picker.dart';

import 'package:image/image.dart' as img;


class SuggestionSaveController extends GetxController {
  final Rx<File?> selectedFile = Rx<File?>(null);
  final RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final SuggestionSaveRepository _repository = SuggestionSaveRepository();

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) selectedFile.value = File(image.path);
  }

  // Pick any file from device
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      selectedFile.value = File(result.files.first.path!);
    }
  }

  // Compress image & convert to base64
  Future<String> _compressAndConvertImage(File file) async {
    final bytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(bytes);
    if (image == null) throw Exception("Failed to decode image");
    final resized = img.copyResize(image, width: 800); // Resize width
    final compressedBytes = img.encodeJpg(resized, quality: 80); // Compress
    return "data:image/jpeg;base64,${base64Encode(compressedBytes)}";
  }

  /// Save suggestion
  Future<void> saveSuggestionForm() async {
    if (!formKey.currentState!.validate()) return;

    String? base64File;

    if (selectedFile.value != null) {
      final file = selectedFile.value!;
      if (file.path.endsWith('.jpg') ||
          file.path.endsWith('.jpeg') ||
          file.path.endsWith('.png')) {
        // Compress image using _compressAndConvertImage
        base64File = await _compressAndConvertImage(file);
      } else {
        // Any other file type, just convert to base64
        final bytes = await file.readAsBytes();
        base64File = "data:application/octet-stream;base64,${base64Encode(bytes)}";
      }
    }

    isLoading.value = true;
    try {
      final SaveSuggestionModel request = SaveSuggestionModel(
        message: descriptionController.text.trim(),
        fileSource: base64File,
      );

      final SaveSuggestionModel response =
      await _repository.saveSuggestion(vehicle: request);

      if (response.status == 200) {
        CustomNotifier.showPopup(
          message: response.message ?? "Suggestion submitted successfully",
          isSuccess: true,
        );
        Future.delayed(const Duration(seconds: 2), () {
          if (Get.isDialogOpen ?? false) Get.back();
          Get.offAllNamed(AppRoutes.dashBoard);
        });
      } else {
        CustomNotifier.showPopup(
          message: response.message ?? "Something went wrong",
          isSuccess: false,
        );
      }
    } catch (e) {
      CustomNotifier.showPopup(message: e.toString(), isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }
}
