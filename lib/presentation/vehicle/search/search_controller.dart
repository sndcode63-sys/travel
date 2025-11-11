import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../models/vehicle/notify_model.dart';
import '../../../models/vehicle/vehicle_search.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../addmetting/add_meeting_screen.dart';
import 'repository_vehicle_search.dart';

class SearchVehicleController extends GetxController {
  final RepositoryVehicleSearch _repository = RepositoryVehicleSearch();

  RxList<VehicleSearch> searchResults = <VehicleSearch>[].obs;
  RxMap<String, RxBool> switchStatus = <String, RxBool>{}.obs;
  RxBool isLoading = false.obs;
  RxBool hasData = false.obs;
  RxBool hasSearched = false.obs;
  Rx<File?> capturedImages = Rx<File?>(null);
  final formKey = GlobalKey<FormState>();


// TEXT EDITOR CONTROLLER
  final TextEditingController searchController = TextEditingController();
  final TextEditingController descriptionNotify = TextEditingController();


  Future<void> searchData(String query) async {
    hasSearched.value = true;

    if (query.trim().length < 3) {
      searchResults.clear();
      hasData.value = false;
      return;
    }

    _repository.cancelRequest();

    isLoading.value = true;

    try {
      final results = await _repository.searchUsers(searchText: query.trim());
      searchResults.assignAll(results);

      // Initialize switch states for each vehicle
      for (var vehicle in results) {
        if (!switchStatus.containsKey(vehicle.id)) {
          switchStatus[vehicle.id!] = false.obs;
        }
      }

      hasData.value = results.isNotEmpty;
    } catch (e) {
      debugPrint(" Search Error: $e");
      hasData.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openCamera({CameraLensDirection lensDirection = CameraLensDirection.back}) async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      // Pass lensDirection to CameraScreen
      final file = await Get.to<File?>(() => CameraScreen(lensDirection: lensDirection));
      if (file != null) {
        capturedImages.value = file;
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

  Future<void> saveForm(String vehicleId) async {
    if (!formKey.currentState!.validate()) return;

    if (capturedImages.value == null) {
      CustomNotifier.showSnackbar(
        message: "Please capture or upload an image",
        isSuccess: false,
      );
      return;
    }

    isLoading.value = true;
    try {
      String base64Image = base64Encode(await capturedImages.value!.readAsBytes());

      final vehicle = NotifyModel(
        vehicleid: vehicleId,
        description: descriptionNotify.text.trim(),
        vehicleImage: base64Image,
      );

      final NotifyModel response = await _repository.saveVehicle(vehicle: vehicle);

      if (response.status == 200) {
        CustomNotifier.showPopup(
          message: response.message ?? "",
          isSuccess: true,
        );

        Future.delayed(const Duration(seconds: 2), () {
          if (Get.isDialogOpen ?? false) Get.back();
          Get.offAllNamed(AppRoutes.dashBoard);
        });
      } else {
        CustomNotifier.showPopup(
          message: response.message ?? "",
          isSuccess: false,
        );
      }
    } catch (e) {
      CustomNotifier.showPopup(
        message: e.toString(),
        isSuccess: false,
      );
    } finally {
      isLoading.value = false;
    }
  }



  void toggleSwitch(String vehicleId) {
    if (switchStatus.containsKey(vehicleId)) {
      switchStatus[vehicleId]!.value = !switchStatus[vehicleId]!.value;
    }
  }

  void removeVehicle(String? vehicleId) {
    if (vehicleId == null) return;
    searchResults.removeWhere((element) => element.id == vehicleId);
    switchStatus.remove(vehicleId);
    hasData.value = searchResults.isNotEmpty;
  }

  void clearSearch() {
    searchController.clear();
    searchResults.clear();
    switchStatus.clear();
    hasSearched.value = false;
    hasData.value = false;
  }

  @override
  void onClose() {
    _repository.cancelRequest();
    searchController.dispose();
    super.onClose();
  }
}
