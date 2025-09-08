import 'package:get/get.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../locall_database/local_database_related.dart';
import '../../locall_database/repository.dart';
import '../../tab_retailrDistributers/list_distributres.dart';

class RetailerController extends GetxController {
  final DistributorRetailerRepository _repo = DistributorRetailerRepository();

  // UI state
  RxInt selectedType = 0.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  // Form controllers
  final businessNameController = TextEditingController();
  final businessTypeController = TextEditingController();
  final addressController = TextEditingController();
  final gstController = TextEditingController();
  final pinCodeController = TextEditingController();
  final personNameController = TextEditingController();
  final mobileController = TextEditingController();

  // Dropdown values
  RxString brand = "".obs;
  RxString state = "".obs;
  RxString city = "".obs;
  RxString region = "".obs;
  RxString area = "".obs;
  RxString bankName = "".obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  // Future<void> submit() async {
  //   final model = DistributorRetailerModel(
  //     type: selectedType.value,
  //     businessName: businessNameController.text,
  //     businessType: businessTypeController.text,
  //     brand: brand.value,
  //     address: addressController.text,
  //     state: state.value,
  //     city: city.value,
  //     region: region.value,
  //     area: area.value,
  //     bankName: bankName.value,
  //     gstNo: gstController.text,
  //     pinCode: pinCodeController.text,
  //     personName: personNameController.text,
  //     mobile: mobileController.text,
  //     imagePath: selectedImage.value?.path,
  //   );
  //
  //   await _repo.addDistributorRetailer(model);
  //   Get.snackbar("Success", "Data Saved to Hive!");
  //   clearForm();
  // }

  Future<void> submit() async {
    final model = DistributorRetailerModel(
      type: selectedType.value,
      businessName: businessNameController.text,
      businessType: businessTypeController.text,
      brand: brand.value,
      address: addressController.text,
      state: state.value,
      city: city.value,
      region: region.value,
      area: area.value,
      bankName: bankName.value,
      gstNo: gstController.text,
      pinCode: pinCodeController.text,
      personName: personNameController.text,
      mobile: mobileController.text,
      imagePath: selectedImage.value?.path,
    );

    await _repo.addDistributorRetailer(model);

    Get.snackbar("Success", "Data Saved to Hive!");

    clearForm();

    // ✅ Navigate to list screen
    Get.off(() => const DistributorRetailerListScreen());
  }


  void clearForm() {
    businessNameController.clear();
    businessTypeController.clear();
    addressController.clear();
    gstController.clear();
    pinCodeController.clear();
    personNameController.clear();
    mobileController.clear();
    selectedImage.value = null;
    brand.value = "";
    state.value = "";
    city.value = "";
    region.value = "";
    area.value = "";
    bankName.value = "";
  }
}
