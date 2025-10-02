import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/profiles/address_profile_model.dart';
import 'profile_info_repository.dart';


import 'package:get_storage/get_storage.dart';

class ProfileInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Dropdown controllers
  final cityController = SingleValueDropDownController();
  final stateController = SingleValueDropDownController();
  final countryController = SingleValueDropDownController();

  // Selected values
  RxString selectedCity = "".obs;
  RxString selectedState = "".obs;
  RxString selectedCountry = "".obs;
  RxBool isLoading = false.obs;


  // Text controllers
  final pincodeController = TextEditingController();
  final addressController = TextEditingController();

  // Dropdown options dynamically filled
  RxList<DropDownValueModel> cityOptions = <DropDownValueModel>[].obs;
  RxList<DropDownValueModel> stateOptions = <DropDownValueModel>[].obs;
  RxList<DropDownValueModel> countryOptions = <DropDownValueModel>[].obs;

  final storage = GetStorage();

  String? validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Please select $fieldName";
    }
    return null;
  }


  @override
  void onInit() {
    super.onInit();
    _loadProfileInfo();
  }

  // Load profile info from GetStorage
  void _loadProfileInfo() {
    pincodeController.text = storage.read('pincode') ?? '';
    addressController.text = storage.read('address') ?? '';
    selectedCity.value = storage.read('city') ?? '';
    selectedState.value = storage.read('state') ?? '';
    selectedCountry.value = storage.read('country') ?? '';

    if (selectedCity.value.isNotEmpty) {
      cityOptions.value = [
        DropDownValueModel(name: selectedCity.value, value: selectedCity.value)
      ];
      cityController.setDropDown(cityOptions.value[0]);
    }
    if (selectedState.value.isNotEmpty) {
      stateOptions.value = [
        DropDownValueModel(name: selectedState.value, value: selectedState.value)
      ];
      stateController.setDropDown(stateOptions.value[0]);
    }
    if (selectedCountry.value.isNotEmpty) {
      countryOptions.value = [
        DropDownValueModel(name: selectedCountry.value, value: selectedCountry.value)
      ];
      countryController.setDropDown(countryOptions.value[0]);
    }
  }

  Future<void> fetchAddressFromPin(String pin) async {
    if (pin.length != 6) return;

    try {
      final model = await ProfileInfoRepository.fetchAddressFromPin(pin);

      if (model.status == 200 && model.city != null && model.city!.isNotEmpty) {
        addressController.text = model.area?.first ?? "";
        selectedCity.value = model.city!.first;
        selectedState.value = model.state!.first;
        selectedCountry.value = model.country!.first;

        cityOptions.value =
            model.city!.map((c) => DropDownValueModel(name: c, value: c)).toList();
        stateOptions.value =
            model.state!.map((s) => DropDownValueModel(name: s, value: s)).toList();
        countryOptions.value =
            model.country!.map((c) => DropDownValueModel(name: c, value: c)).toList();

        cityController.setDropDown(cityOptions.value[0]);
        stateController.setDropDown(stateOptions.value[0]);
        countryController.setDropDown(countryOptions.value[0]);
      } else {
        Get.snackbar(
          "Error",
          "Invalid PIN code",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch address",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        "Error",
        "Please fill all required fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      final model = AddressProfileModel(
        actiontype: "address-information",
        address: addressController.text,
        city: selectedCity.value,
        state: selectedState.value,
        country: selectedCountry.value,
        pincode: pincodeController.text,
      );

      await ProfileInfoRepository.updateProfile(model);

      // Save locally
      storage.write('pincode', pincodeController.text);
      storage.write('address', addressController.text);
      storage.write('city', selectedCity.value);
      storage.write('state', selectedState.value);
      storage.write('country', selectedCountry.value);

      Get.snackbar(
        "Success",
        "Profile Updated Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update profile",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    pincodeController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.onClose();
  }
}
