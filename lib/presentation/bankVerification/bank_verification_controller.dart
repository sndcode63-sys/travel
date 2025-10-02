import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/profiles/bank_info_model.dart';
import '../../models/profiles/getBankModel.dart';
import 'bank_verification_repo.dart';


class BankVerificationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  final ifscController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final addressController = TextEditingController();
  final branchController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();

  // For CustomDropDownField
  RxString accountType = 'Saving'.obs;
  final accountTypeController = SingleValueDropDownController();

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    print("BankVerificationController initialized");

    _loadBankInfo();

    // IFSC listener
    ifscController.addListener(() {
      final value = ifscController.text.trim();
      print("IFSC changed: $value"); // Debug
      if (value.length == 11) {
        fetchBankInfoByIfsc(value);
      }
    });
  }

  void _loadBankInfo() {
    print("Loading bank info from storage");
    ifscController.text = storage.read('ifscCode') ?? '';
    bankNameController.text = storage.read('bankName') ?? '';
    accountNumberController.text = storage.read('accountNumber') ?? '';
    addressController.text = storage.read('address') ?? '';
    branchController.text = storage.read('branch') ?? '';
    stateController.text = storage.read('state') ?? '';
    districtController.text = storage.read('district') ?? '';
    accountType.value = storage.read('accountType') ?? 'Saving';
    accountTypeController.dropDownValue = DropDownValueModel(
        name: accountType.value, value: accountType.value);
  }

  // Fetch bank info by IFSC
  Future<void> fetchBankInfoByIfsc(String ifscCode) async {
    if (ifscCode.isEmpty || ifscCode.length != 11) return;

    try {
      isLoading.value = true;
      print("Fetching bank info for IFSC: $ifscCode");

      final Getbankmodel bankData = await BankInfoRepository.getBankByIfsc(ifscCode);
      print("BANK DATA RECEIVED: ${bankData.toJson()}");

      if (bankData.status == 200) {
        bankNameController.text = bankData.bank ?? '';
        accountNumberController.text = bankData.accountNumber ?? '';
        accountType.value = bankData.accountType ?? 'Saving';
        accountTypeController.dropDownValue = DropDownValueModel(
            name: accountType.value, value: accountType.value);

        // Save locally
        storage.write('ifscCode', ifscCode);
        storage.write('bankName', bankData.bank ?? '');
        storage.write('accountNumber', bankData.accountNumber ?? '');
        storage.write('accountType', bankData.accountType ?? 'Saving');

        print("Bank info auto-filled successfully");
      } else {
        Get.snackbar("Error", "Invalid IFSC code");
        print("Invalid IFSC code");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch bank details");
      print("Error fetching bank info: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Update bank info
  Future<void> updateBankInfo() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final model = BankInfoModel(
        actiontype: "bank-information",
        ifscCode: ifscController.text,
        bankName: bankNameController.text,
        accountNumber: accountNumberController.text,
        accountType: accountType.value,
      );

      await BankInfoRepository.updateBankInfo(model);
      storage.write('accountType', accountType.value);

      Get.snackbar("Success", "Bank Info Updated Successfully");
      print("Bank info updated: ${model.toJson()}");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    ifscController.dispose();
    bankNameController.dispose();
    accountNumberController.dispose();
    addressController.dispose();
    branchController.dispose();
    stateController.dispose();
    districtController.dispose();
    accountTypeController.dispose();
    super.onClose();
  }
}
