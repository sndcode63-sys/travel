import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:travell_booking_app/utlis/app_routes.dart';
import '../../models/profiles/relation_get.dart';
import '../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import 'relation_repository.dart';

class RelationInformationController extends GetxController {
  // Dropdown controllers
  final selectedR = SingleValueDropDownController();
  final selectedTeam = SingleValueDropDownController();
  final selectedPin = SingleValueDropDownController();
  final selectedLocation = SingleValueDropDownController();

  // Selected dropdown values (store both id and name)
  Rx<DropDownValueModel?> selectedRera = Rx<DropDownValueModel?>(null);
  Rx<DropDownValueModel?> selectedTeamValue = Rx<DropDownValueModel?>(null);
  Rx<DropDownValueModel?> selectedPinValue = Rx<DropDownValueModel?>(null);
  Rx<DropDownValueModel?> selectedLocationValue = Rx<DropDownValueModel?>(null);

  // Text controller
  final reraNumberController = TextEditingController();

  // Loading state
  RxBool isUpdating = false.obs;
  RxBool isLoadingMaster = true.obs;

  // Master data from API
  Rx<RelationGet?> masterData = Rx<RelationGet?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchMasterList();
  }

  void onReraSerialChanged(DropDownValueModel? newValue) {
    selectedRera.value = newValue;

    if (newValue != null) {
      final isApplied = newValue.name == "Applied";

      if (isApplied) {
        reraNumberController.clear();
      }

      else if (reraNumberController.text.isEmpty) {
        reraNumberController.text = newValue.name;
      }
    }
  }


  Future<void> fetchMasterList() async {
    try {
      isLoadingMaster.value = true;
      masterData.value = await RelationRepository().getSefList();

      final first = masterData.value;
      if (first != null) {
        if (first.reraSerial != null && first.reraSerial!.isNotEmpty) {
          final initialRera = DropDownValueModel(
            name: first.reraSerial!.first.name ?? "",
            value: first.reraSerial!.first.id.toString(),
          );
          selectedRera.value = initialRera;
          selectedR.dropDownValue = initialRera;

          if (first.currentReraNumber != null && first.currentReraNumber!.isNotEmpty) {
            reraNumberController.text = first.currentReraNumber!;
          } else {
            onReraSerialChanged(initialRera);
          }
        }

        // Prefill Team
        if (first.teams != null && first.teams!.isNotEmpty) {
          selectedTeamValue.value = DropDownValueModel(
            name: first.teams!.first.name ?? "",
            value: first.teams!.first.id.toString(),
          );
          selectedTeam.dropDownValue = selectedTeamValue.value;
        }

        // Prefill Pin
        if (first.pin != null && first.pin!.isNotEmpty) {
          selectedPinValue.value = DropDownValueModel(
            name: first.pin!.first.name ?? "",
            value: first.pin!.first.id.toString(),
          );
          selectedPin.dropDownValue = selectedPinValue.value;
        }

        // Prefill Location
        if (first.location != null && first.location!.isNotEmpty) {
          selectedLocationValue.value = DropDownValueModel(
            name: first.location!.first.name ?? "",
            value: first.location!.first.id.toString(),
          );
          selectedLocation.dropDownValue = selectedLocationValue.value;
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load dropdown data",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingMaster.value = false;
    }
  }

  Future<void> updateRelationInfo() async {
    if (selectedRera.value == null ||
        selectedTeamValue.value == null ||
        selectedPinValue.value == null ||
        selectedLocationValue.value == null ||
        reraNumberController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isUpdating.value = true;
    try {
      final response = await RelationRepository.updateRelationInfo(
        reraSerialId: int.parse(selectedRera.value!.value),
        reraNumber: reraNumberController.text.trim(),
        teamId: int.parse(selectedTeamValue.value!.value),
        pinId: int.parse(selectedPinValue.value!.value),
        locationId: int.parse(selectedLocationValue.value!.value),
      );

      // Update dropdown values based on response
      if (response.reraSerial != null) {
        selectedRera.value = DropDownValueModel(
          name: response.reraSerial!,
          value: selectedRera.value!.value,
        );
        selectedR.dropDownValue = selectedRera.value;
      }

      if (response.teamName != null) {
        selectedTeamValue.value = DropDownValueModel(
          name: response.teamName!,
          value: selectedTeamValue.value!.value,
        );
        selectedTeam.dropDownValue = selectedTeamValue.value;
      }

      if (response.pinName != null) {
        selectedPinValue.value = DropDownValueModel(
          name: response.pinName!,
          value: selectedPinValue.value!.value,
        );
        selectedPin.dropDownValue = selectedPinValue.value;
      }

      if (response.locationName != null) {
        selectedLocationValue.value = DropDownValueModel(
          name: response.locationName!,
          value: selectedLocationValue.value!.value,
        );
        selectedLocation.dropDownValue = selectedLocationValue.value;
      }

      if (response.reraNumber != null) {
        reraNumberController.text = response.reraNumber!;
      }


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
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  @override
  void onClose() {
    reraNumberController.dispose();
    selectedR.dispose();
    selectedTeam.dispose();
    selectedPin.dispose();
    selectedLocation.dispose();
    super.onClose();
  }
}