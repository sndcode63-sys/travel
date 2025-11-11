import 'dart:io';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../models/vehicle/add_vehicle.dart';
import '../../../models/vehicle/brand_name.dart';
import '../../../models/vehicle/update_vehicle_model.dart';
import '../../../models/vehicle/vehicle_list.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../addmetting/add_meeting_screen.dart';
import 'update_vehicle_repository.dart';
// update_vehicle_controller.dart

import 'dart:io';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travell_booking_app/utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';

import '../../../models/vehicle/brand_name.dart';
import '../../../models/vehicle/vehicle_list.dart';
import 'update_vehicle_repository.dart';



class UpdateVehicleController extends GetxController {
  RxBool isLoading = false.obs;

  final UpdateVehicleRepository _updateVehicleRepository = UpdateVehicleRepository();

  final formKey = GlobalKey<FormState>();
  Rx<File?> capturedImage = Rx<File?>(null);

  final TextEditingController registrationController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  final SingleValueDropDownController vehicleTypeController = SingleValueDropDownController();
  final SingleValueDropDownController brandControllerDropdown = SingleValueDropDownController();

  Rx<DropDownValueModel?> selectedVehicleType = Rx<DropDownValueModel?>(null);
  Rx<DropDownValueModel?> selectedBrand = Rx<DropDownValueModel?>(null);

  final List<DropDownValueModel> vehicleTypes = const [
    DropDownValueModel(name: '2 Wheeler', value: '2 Wheeler'),
    DropDownValueModel(name: '4 Wheeler', value: '4 Wheeler'),
  ];

  RxList<BrandName> brandList = <BrandName>[].obs;

  @override
  void onInit() {
    super.onInit();
    final vehicle = Get.arguments as VehicleList?;

    if (vehicle != null) {
      registrationController.text = vehicle.registrationNumber ?? "";
      modelController.text = vehicle.modelName ?? "";
      colorController.text = vehicle.color ?? "";

      selectedVehicleType.value = vehicle.type != null
          ? DropDownValueModel(name: vehicle.type!, value: vehicle.type!)
          : null;

      // Update dropdown controller for UI
      vehicleTypeController.dropDownValue = selectedVehicleType.value;

      if (vehicle.type != null) {
        onVehicleTypeChanged(selectedVehicleType.value).then((_) {
          if (vehicle.brandName != null) {
            final brandItem = brandList.firstWhere(
                    (brand) => brand.name == vehicle.brandName,
                orElse: () => BrandName(name: vehicle.brandName));
            selectedBrand.value =
                DropDownValueModel(name: brandItem.name ?? "", value: brandItem.name ?? "");
            brandControllerDropdown.dropDownValue = selectedBrand.value;
          }
        });
      }
    }
  }


  Future<void> onVehicleTypeChanged(DropDownValueModel? value) async {
    selectedVehicleType.value = value;
    selectedBrand.value = null;
    brandControllerDropdown.clearDropDown();
    brandList.clear();

    if (value != null) {
      try {
        isLoading.value = true;
        final brands = await _updateVehicleRepository.getBrandsByVehicleType(value.value.toString());
        brandList.value = brands;
      } catch (e) {
        CustomNotifier.showSnackbar(message: e.toString(), isSuccess: false);
      } finally {
        isLoading.value = false;
      }
    }
  }

  Rx<File?> capturedNotifyImage = Rx<File?>(null);
  final TextEditingController descriptionNotify = TextEditingController();

// Open camera for notify
  Future<void> openCamera({CameraLensDirection lensDirection = CameraLensDirection.back}) async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final file = await Get.to<File?>(() => CameraScreen(lensDirection: lensDirection));
      if (file != null) capturedImage.value = file;
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

// Save notify
  Future<void> updateVehicle(String vehicleId) async {
    if (!formKey.currentState!.validate()) return;

    if (capturedImage.value == null) {
      CustomNotifier.showSnackbar(
          message: "Please capture vehicle image", isSuccess: false);
      return;
    }

    // Debug: Check vehicleId
    print("========= VEHICLE UPDATE DEBUG =========");
    print("Vehicle ID: $vehicleId");
    print("========================================");
    if (vehicleId.isEmpty) {
      print("DEBUG: Vehicle ID is empty! Cannot proceed.");
      CustomNotifier.showPopup(
          message: "Vehicle ID is missing", isSuccess: false);
      return;
    }

    isLoading.value = true;
    try {
      String base64Image = base64Encode(await capturedImage.value!.readAsBytes());

      final updateData = {
        "id": vehicleId,
        "_id": vehicleId,
        "registration_number": registrationController.text.trim(),
        "model_name": modelController.text.trim(),
        "color": colorController.text.trim(),
        "type": selectedVehicleType.value?.value ?? "",
        "brand": selectedBrand.value?.value ?? "",
        "fileSource": base64Image,
      };



      // Debug: Print full payload before sending
      print("DEBUG: Payload for update -> $updateData");

      final response = await _updateVehicleRepository.updateVehicle(updateData);

      // Debug: Print backend response
      print("DEBUG: Backend response -> ${response.toJson()}");

      if (response.status == 200) {
        CustomNotifier.showPopup(
          message: response.message ?? "",
          isSuccess: true,
        );
        Future.delayed(const Duration(seconds: 2), () {
          if (Get.isDialogOpen ?? false) Get.back(result: true);
        });
      } else {
        CustomNotifier.showPopup(
          message: response.message ?? "Failed to update vehicle",
          isSuccess: false,
        );
      }
    } catch (e) {
      print("DEBUG: Exception caught -> $e");
      CustomNotifier.showPopup(message: e.toString(), isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onClose() {
    registrationController.dispose();
    modelController.dispose();
    colorController.dispose();
    super.onClose();
  }
}


