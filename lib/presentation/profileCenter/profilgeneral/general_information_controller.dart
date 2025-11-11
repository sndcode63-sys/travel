import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../profile_center_controller.dart';
import 'repository_general_profile.dart';


class GeneralInformationController extends GetxController {
  final ProfileCenterController profileController = Get.find<ProfileCenterController>();

  // TextEditingControllers
  final fullNameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final spouseNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactNumberController = TextEditingController();
  final nomineeNameController = TextEditingController();
  final nomineeRelationController = TextEditingController();

  // Dropdown controller for Gender
  final SingleValueDropDownController genderDropDownController = SingleValueDropDownController();
  RxString selectedGender = ''.obs;

  // DOB
  RxInt selectedDay = 1.obs;
  RxInt selectedMonth = 1.obs;
  RxInt selectedYear = 2000.obs;

  RxBool isLoading = false.obs;

  // Dropdown lists
  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years = List.generate(DateTime.now().year - 1900 + 1, (index) => 1900 + index);

  // Form validation
  RxBool isFormValid = false.obs;

  void validateFormFields() {
    isFormValid.value =
        fullNameController.text.trim().isNotEmpty &&
            fatherNameController.text.trim().isNotEmpty &&
            emailController.text.trim().isNotEmpty &&
            contactNumberController.text.trim().length == 10 &&
            selectedGender.value.isNotEmpty;
  }

  void prefillData() {
    final user = profileController.userData.value;

    // TextFields
    fullNameController.text = user.fullName ?? '';
    fatherNameController.text = user.fatherName ?? '';
    motherNameController.text = user.motherName ?? '';
    spouseNameController.text = user.spouseName ?? '';
    emailController.text = user.email ?? '';
    contactNumberController.text = user.mobileNumber ?? '';
    nomineeNameController.text = user.nomineeName ?? '';
    nomineeRelationController.text = user.nomineeRelation ?? '';

    // Gender
    if (user.gender != null && user.gender!.isNotEmpty) {
      selectedGender.value = user.gender!;
      genderDropDownController.dropDownValue = DropDownValueModel(
        name: user.gender!,
        value: user.gender!,
      );
    }

    // DOB
    if (user.dob != null && user.dob!.isNotEmpty) {
      final dobParts = user.dob!.split('-');
      if (dobParts.length == 3) {
        selectedYear.value = int.tryParse(dobParts[0]) ?? 2000;
        selectedMonth.value = int.tryParse(dobParts[1]) ?? 1;
        selectedDay.value = int.tryParse(dobParts[2]) ?? 1;
      }
    }

    validateFormFields();
  }

  Future<void> saveGeneralInfo(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final response = await GeneralProfileRepository.updateGeneralInfo(
        name: fullNameController.text.trim(),
        fatherName: fatherNameController.text.trim(),
        motherName: motherNameController.text.trim(),
        spouseName: spouseNameController.text.trim(),
        email: emailController.text.trim(),
        phone: contactNumberController.text.trim(),
        date: selectedDay.value.toString().padLeft(2, '0'),
        month: selectedMonth.value.toString().padLeft(2, '0'),
        year: selectedYear.value.toString(),
        gender: selectedGender.value.trim(),
        nomineeRelation: nomineeRelationController.text.trim(),
        nomineeName: nomineeNameController.text.trim(),
      );

      profileController.userData.update((user) {
        user?.fullName = fullNameController.text.trim();
        user?.fatherName = fatherNameController.text.trim();
        user?.motherName = motherNameController.text.trim();
        user?.spouseName = spouseNameController.text.trim();
        user?.email = emailController.text.trim();
        user?.mobileNumber = contactNumberController.text.trim();
        user?.gender = selectedGender.value.trim();
        user?.dob =
        '${selectedYear.value.toString().padLeft(4, '0')}-${selectedMonth.value.toString().padLeft(2, '0')}-${selectedDay.value.toString().padLeft(2, '0')}';
        user?.nomineeName = nomineeNameController.text.trim();
        user?.nomineeRelation = nomineeRelationController.text.trim();
      });

      isLoading.value = false;

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
      isLoading.value = false;
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Add listeners for validation
    fullNameController.addListener(validateFormFields);
    fatherNameController.addListener(validateFormFields);
    emailController.addListener(validateFormFields);
    contactNumberController.addListener(validateFormFields);

    // Prefill data on first load
    if (profileController.userData.value.id != null) {
      prefillData();
    } else {
      ever(profileController.userData, (_) => prefillData());
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    spouseNameController.dispose();
    emailController.dispose();
    contactNumberController.dispose();
    nomineeNameController.dispose();
    nomineeRelationController.dispose();
    super.onClose();
  }
}
