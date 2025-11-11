import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/associate/associate_profile_info_model.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../profileCenter/profile_center_controller.dart';
import 'package:get_storage/get_storage.dart';

import 'associate_profile_info_repository.dart';

class AssociateProfileInfoController extends GetxController {
  final ProfileCenterController profileCenterController =
      Get.find<ProfileCenterController>();

  final formKey = GlobalKey<FormState>();

  RxString associateId = "".obs;





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

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['associate_id'] != null) {
      associateId.value = args['associate_id'].toString();
      print("🔹 Received Associate ID: ${associateId.value}");
    }
    _prefillFromUserData();


    // React to updates of ProfileCenterController userData
    ever(profileCenterController.userData, (_) => _prefillFromUserData());
  }

  void _prefillFromUserData() {
    final user = profileCenterController.userData.value;

    pincodeController.text = user.pincode ?? '';
    addressController.text = user.address ?? '';
    selectedCity.value = user.city ?? '';
    selectedState.value = user.state ?? '';
    selectedCountry.value = user.country ?? '';

    if (selectedCity.value.isNotEmpty) {
      cityOptions.value = [
        DropDownValueModel(name: selectedCity.value, value: selectedCity.value),
      ];
      cityController.dropDownValue = cityOptions.value.first;
    }
    if (selectedState.value.isNotEmpty) {
      stateOptions.value = [
        DropDownValueModel(
          name: selectedState.value,
          value: selectedState.value,
        ),
      ];
      stateController.dropDownValue = stateOptions.value.first;
    }
    if (selectedCountry.value.isNotEmpty) {
      countryOptions.value = [
        DropDownValueModel(
          name: selectedCountry.value,
          value: selectedCountry.value,
        ),
      ];
      countryController.dropDownValue = countryOptions.value.first;
    }
  }

  String? validateDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Please select $fieldName";
    }
    return null;
  }

  Future<void> fetchAddressFromPin(String pin) async {
    if (pin.length != 6) return;

    try {
      final model = await AssociateProfileInfoRepository.fetchAddressFromPin(pin);

      if (model.status == 200 && model.city != null && model.city!.isNotEmpty) {
        addressController.text = model.area?.first ?? "";
        selectedCity.value = model.city!.first;
        selectedState.value = model.state!.first;
        selectedCountry.value = model.country!.first;

        cityOptions.value =
            model.city!
                .map((c) => DropDownValueModel(name: c, value: c))
                .toList();
        stateOptions.value =
            model.state!
                .map((s) => DropDownValueModel(name: s, value: s))
                .toList();
        countryOptions.value =
            model.country!
                .map((c) => DropDownValueModel(name: c, value: c))
                .toList();

        cityController.dropDownValue = cityOptions.value[0];
        stateController.dropDownValue = stateOptions.value[0];
        countryController.dropDownValue = countryOptions.value[0];
      } else {
        Get.snackbar(
          "Error",
          "Invalid PIN code",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch address",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final model = AssociateProfileInfoModel(
        associateId: associateId.value,
        actiontype: "address-information",
        address: addressController.text,
        city: selectedCity.value,
        state: selectedState.value,
        country: selectedCountry.value,
        pincode: pincodeController.text,
      );

      final response = await AssociateProfileInfoRepository.associateProfile(model);

      //  Save locally
      storage.write('pincode', response.pincode ?? pincodeController.text);
      storage.write('address', response.address ?? addressController.text);
      storage.write('city', response.city ?? selectedCity.value);
      storage.write('state', response.state ?? selectedState.value);
      storage.write('country', response.country ?? selectedCountry.value);

      //  Update userData instantly for reactive UI
      final user = profileCenterController.userData.value;
      user.address = response.address ?? addressController.text;
      user.city = response.city ?? selectedCity.value;
      user.state = response.state ?? selectedState.value;
      user.country = response.country ?? selectedCountry.value;
      user.pincode = response.pincode ?? pincodeController.text;

      profileCenterController.userData.value = user;

      if (response.status == 200) {
        CustomNotifier.showPopup(
          message: response.message ?? "",
          isSuccess: true,
        );

        Future.delayed(const Duration(seconds: 2), () {
          if (Get.isDialogOpen ?? false) Get.back();
          Get.offAllNamed(
            AppRoutes.associateRelationInfo,
            arguments: {'associate_id': associateId.value},
          );

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
        "Failed to update profile: $e",
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
