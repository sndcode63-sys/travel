import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dispute_enter_repository.dart';

class DisputeEnterSummaryController  extends GetxController{

  TextEditingController subjetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController staffNameController = TextEditingController();
  RxBool isLoading = false.obs;



  Future<void> saveDispute(staffId) async {

    try {
      isLoading.value = true;

      final response = await DisputeEnterRepository.updateDispute(
        caseInDetails: subjetController.text.trim(),
        subject: descriptionController.text.trim(),
        staffName: staffId.trim(),

      );
      isLoading.value = false;
      if(response.status ==200){
        Get.snackbar(
          "Success",
          response.message ?? "",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

      }else{
        Get.snackbar(
          "Error",
          response.message ?? "",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

      }

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

  @override
  void dispose() {
    subjetController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

}