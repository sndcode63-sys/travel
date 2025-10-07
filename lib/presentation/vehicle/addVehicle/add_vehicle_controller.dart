import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../addVisit/addVisitForClientInfo/add_client_information.dart';

class AddVehicleController extends GetxController{

  RxBool isLoading = false.obs;
  RxBool hasSearched = false.obs;
  RxBool hasData = false.obs;

  RxList<String> searchResults = <String>[].obs;

  final TextEditingController searchController = TextEditingController();



  void searchData(String query) {
    hasSearched.value = true;
    if (query.trim().length < 3) {
      searchResults.clear();
      hasData.value = false;
      return;
    }

    isLoading.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      searchResults.clear();
      hasData.value = searchResults.isNotEmpty;
      isLoading.value = false;
    });
  }


  final vehicleType = SingleValueDropDownController();
  Rx<DropDownValueModel?> vehicleController = Rx<DropDownValueModel?>(null);
    Rx<File?> capturedImage = Rx<File?>(null);


    Future<void> openCamera() async {
      var status = await Permission.camera.request();
      if (status.isGranted) {
        final file = await Get.to<File?>(() => const CameraScreen());
        if (file != null) {
          capturedImage.value = file;
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



}