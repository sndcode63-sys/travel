import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();


  // Single-value dropdown controllers
  final reraSerialController = SingleValueDropDownController();
  final teamController = SingleValueDropDownController();

  // Observables for selected values
  RxString selectedReraSerial = "".obs;
  RxString selectedTeam = "".obs;
  // TextEditingControllers
  final pincodeController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  void onUpdate() {
    if (formKey.currentState!.validate()) {
      Get.snackbar("Success", "Profile Updated Successfully",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Please fill all required fields",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    pincodeController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    reraSerialController.dispose();
    teamController.dispose();
    super.onClose();
  }
}
