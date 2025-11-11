import 'dart:io';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../models/vehicle/add_vehicle.dart';
import '../../../models/vehicle/brand_name.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../addmetting/add_meeting_screen.dart';
import 'vehicle_repository.dart';

class AddVehicleController extends GetxController {
  RxBool isLoading = false.obs;

  final VehicleRepository _vehicleRepository = VehicleRepository();

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
  }

  // Vehicle Type Changed -> fetch brands dynamically
  Future<void> onVehicleTypeChanged(DropDownValueModel? value) async {
    selectedVehicleType.value = value;
    selectedBrand.value = null;
    brandControllerDropdown.clearDropDown();
    brandList.clear();

    if (value != null) {
      try {
        isLoading.value = true;
        final brands = await _vehicleRepository.getBrandsByVehicleType(value.value.toString());
        brandList.value = brands;
      } catch (e) {
        CustomNotifier.showSnackbar(message: e.toString(), isSuccess: false);
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Save Vehicle
  Future<void> saveForm() async {
    if (!formKey.currentState!.validate()) return;

    if (capturedImage.value == null) {
      CustomNotifier.showSnackbar(
        message: "",
        isSuccess: false,
      );
      return;
    }

    isLoading.value = true;
    try {
      String base64Image = base64Encode(await capturedImage.value!.readAsBytes());

      final vehicle = AddVehicle(
        registrationNumber: registrationController.text.trim(),
        modelName: modelController.text.trim(),
        brand: selectedBrand.value!.value.toString(),
        type: selectedVehicleType.value!.value.toString(),
        color: colorController.text.trim(),
        fileSource: base64Image,
      );

      final AddVehicle response = await _vehicleRepository.saveVehicle(vehicle: vehicle);

      if (response.status == 200) {
        CustomNotifier.showPopup(message: response.message ?? "", isSuccess: true);

        Future.delayed(const Duration(seconds: 2), () {
          if (Get.isDialogOpen ?? false) Get.back();
          Get.offAllNamed(AppRoutes.dashBoard);
        });
      } else {
        CustomNotifier.showPopup(message: response.message ?? "", isSuccess: false);
      }
    } catch (e) {
      CustomNotifier.showPopup(message: e.toString(), isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }

  // Open Camera
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

  @override
  void onClose() {
    registrationController.dispose();
    modelController.dispose();
    colorController.dispose();
    super.onClose();
  }
}


