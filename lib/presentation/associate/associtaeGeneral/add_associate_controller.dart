import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../profileCenter/profile_center_controller.dart';
import 'repository_add_associate.dart';


class AddAssociateController extends GetxController {
  final ProfileCenterController profileController = Get.put(ProfileCenterController());

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

  Future<void> saveGeneralInfo(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final response = await RepositoryAddAssociate.updateGeneralInfo(
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

      isLoading.value = false;

      if (response.status == 200) {
        final associateId = response.data?.associateId;

        CustomNotifier.showPopup(
          message: response.message ?? "",
          isSuccess: true,
        );

        Future.delayed(const Duration(seconds: 2), () {
          if (Get.isDialogOpen ?? false) Get.back();

          Get.toNamed(
            AppRoutes.associateProfile,
            arguments: {'associate_id': associateId},
          );
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

    final args = Get.arguments;
    if (args != null && args['associate'] != null) {
      final associate = args['associate'];
      fullNameController.text = associate.fullName ?? '';
      fatherNameController.text = associate.fatherName ?? '';
      motherNameController.text = associate.motherName ?? '';
      spouseNameController.text = associate.spouseName ?? '';
      emailController.text = associate.email ?? '';
      contactNumberController.text = associate.phone2 ?? '';
      nomineeNameController.text = associate.nomineeName ?? '';
      nomineeRelationController.text = associate.nomineeRelation ?? '';
      selectedGender.value = associate.gender ?? '';

      // Gender dropdown
      genderDropDownController.dropDownValue = DropDownValueModel(
        name: selectedGender.value,
        value: selectedGender.value,
      );

      if (associate.dob != null && associate.dob.isNotEmpty) {
        try {
          final parts = associate.dob.split('-');
          selectedYear.value = int.parse(parts[0]);
          selectedMonth.value = int.parse(parts[1]);
          selectedDay.value = int.parse(parts[2]);
        } catch (_) {}
      }
    }

    // Add listeners for form validation
    fullNameController.addListener(validateFormFields);
    fatherNameController.addListener(validateFormFields);
    emailController.addListener(validateFormFields);
    contactNumberController.addListener(validateFormFields);
    ever(selectedGender, (_) => validateFormFields());
    ever(selectedDay, (_) => validateFormFields());
    ever(selectedMonth, (_) => validateFormFields());
    ever(selectedYear, (_) => validateFormFields());

    validateFormFields();
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
