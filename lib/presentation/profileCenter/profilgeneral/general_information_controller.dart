import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'repository_general_profile.dart';



class GeneralInformationController extends GetxController {
  // TextEditingControllers
  final fullNameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final spouseNameController = TextEditingController();
  final emailController = TextEditingController();
  final contactNumberController = TextEditingController();
  final genderController = TextEditingController();
  final nomineeNameController = TextEditingController();
  final nomineeRelationController = TextEditingController();

  // DOB
  RxInt selectedDay = 1.obs;
  RxInt selectedMonth = 1.obs;
  RxInt selectedYear = 2000.obs;

  RxBool isLoading = false.obs;

  // Dropdown lists
  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years =
  List.generate(DateTime.now().year - 1900 + 1, (index) => 1900 + index);

  DateTime get selectedDate =>
      DateTime(selectedYear.value, selectedMonth.value, selectedDay.value);

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
        gender: genderController.text.trim(),
        nomineeRelation: nomineeRelationController.text.trim(),
        nomineeName: nomineeNameController.text.trim(),
      );

      isLoading.value = false;

      Get.snackbar(
        "Success",
        "Profile updated successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      print("API Response: ${response.toJson()}");
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
  RxBool isFormValid = false.obs;

  void validateFormFields() {
    isFormValid.value =
        fullNameController.text.trim().isNotEmpty &&
            fatherNameController.text.trim().isNotEmpty &&
            emailController.text.trim().isNotEmpty &&
            contactNumberController.text.trim().length == 10 &&
            genderController.text.trim().isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();
    fullNameController.addListener(validateFormFields);
    fatherNameController.addListener(validateFormFields);
    emailController.addListener(validateFormFields);
    contactNumberController.addListener(validateFormFields);
    genderController.addListener(validateFormFields);
  }


  @override
  void onClose() {
    fullNameController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    spouseNameController.dispose();
    emailController.dispose();
    contactNumberController.dispose();
    genderController.dispose();
    nomineeNameController.dispose();
    nomineeRelationController.dispose();
    super.onClose();
  }
}
