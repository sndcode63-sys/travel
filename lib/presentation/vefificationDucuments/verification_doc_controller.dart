import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class VerificationDocController extends GetxController {
  Rx<String?> aadharFilePath = Rx<String?>(null);

  Future<void> pickAadharDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      if (result.files.single.size > 1048576) {
        Get.snackbar('Error', 'File size exceeds 1 MB limit.');
        return;
      }
      aadharFilePath.value = result.files.single.path;
    } else {
      Get.snackbar('Cancelled', 'No document selected.');
    }
  }
}
