import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class VerificationDocController extends GetxController {
  Rx<File?> selectedFile = Rx<File?>(null);
  RxString fileExtension = "".obs;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.single.path != null) {
      selectedFile.value = File(result.files.single.path!);
      fileExtension.value = result.files.single.extension ?? "";
    }
  }

  void clearFile() {
    selectedFile.value = null;
    fileExtension.value = "";
  }
}
