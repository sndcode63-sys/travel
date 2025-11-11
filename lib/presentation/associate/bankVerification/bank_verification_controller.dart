import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/associate/associate_bank_info.dart';
import '../../../models/associate/associate_details_get.dart';
import '../../../utlis/app_routes.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../../profileCenter/profile_center_controller.dart';
import 'bank_verification_repo.dart';

class AssociateBankVerificationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxString associateId = "".obs;


  final ifscController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final addressController = TextEditingController();
  final branchController = TextEditingController();
  final stateController = TextEditingController();
  final districtController = TextEditingController();

  RxString accountType = 'Saving'.obs;
  final accountTypeController = SingleValueDropDownController();

  final storage = GetStorage();
  final profileController = Get.find<ProfileCenterController>();

  @override
  void onInit() {
    super.onInit();

    _loadBankInfo();
    associateId.value= Get.arguments['associate_id'];

    if (profileController.userData.value.id != null) {
      prefillBankData();
    } else {
      ever(profileController.userData, (_) => prefillBankData());
    }

    ifscController.addListener(() {
      final value = ifscController.text.trim();
      if (value.length == 11) {
        fetchBankInfoByIfsc(value);
      }
    });
  }

  void prefillBankData() {
    final user = profileController.userData.value;
    if (user.bankInfo != null && user.bankInfo!.isNotEmpty) {
      final bank = user.bankInfo!.first;

      ifscController.text = bank.ifscCode ?? '';
      bankNameController.text = bank.bankName ?? '';
      accountNumberController.text = bank.accountNumber ?? '';
      accountType.value = bank.accountType ?? 'Saving';

      accountTypeController.dropDownValue = DropDownValueModel(
        name: accountType.value,
        value: accountType.value,
      );

      storage.write('ifscCode', ifscController.text);
      storage.write('bankName', bankNameController.text);
      storage.write('accountNumber', accountNumberController.text);
      storage.write('accountType', accountType.value);
    }
  }

  void _loadBankInfo() {
    final savedIfsc = storage.read('ifscCode');
    final savedBankName = storage.read('bankName');
    final savedAccountNumber = storage.read('accountNumber');
    final savedAccountType = storage.read('accountType');

    if (savedIfsc != null ||
        savedBankName != null ||
        savedAccountNumber != null ||
        savedAccountType != null) {
      ifscController.text = savedIfsc ?? '';
      bankNameController.text = savedBankName ?? '';
      accountNumberController.text = savedAccountNumber ?? '';
      accountType.value = savedAccountType ?? 'Saving';

      accountTypeController.dropDownValue = DropDownValueModel(
        name: accountType.value,
        value: accountType.value,
      );
    }
  }

  Future<void> fetchBankInfoByIfsc(String ifscCode) async {
    if (ifscCode.isEmpty || ifscCode.length != 11) return;
    try {
      isLoading.value = true;
      final bankData = await AssociateBankInfoRepository.getBankByIfsc(ifscCode);

      if (bankData.status == 200) {
        bankNameController.text = bankData.bank ?? '';
        accountNumberController.text = bankData.accountNumber ?? '';
        accountType.value = bankData.accountType ?? 'Saving';

        accountTypeController.dropDownValue = DropDownValueModel(
          name: accountType.value,
          value: accountType.value,
        );

        storage.write('ifscCode', ifscCode);
        storage.write('bankName', bankData.bank ?? '');
        storage.write('accountNumber', bankData.accountNumber ?? '');
        storage.write('accountType', accountType.value);
      } else {
        Get.snackbar("Error", "Invalid IFSC code");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch bank details");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateBankInfo() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;

    try {
      final model = AssociateBankInfo(
        actiontype: "bank-information",
        ifscCode: ifscController.text,
        bankName: bankNameController.text,
        accountNumber: accountNumberController.text,
        accountType: accountType.value,
        associateId: associateId.value,
      );

      final response = await AssociateBankInfoRepository.associateUpdateBankInfo(model);

      if (response.status == 200 || response.status == 1) {
        storage.write('ifscCode', ifscController.text);
        storage.write('bankName', bankNameController.text);
        storage.write('accountNumber', accountNumberController.text);
        storage.write('accountType', accountType.value);

        final user = profileController.userData.value;
        final bankInfo = BankInfo(
          ifscCode: model.ifscCode,
          bankName: model.bankName,
          accountNumber: model.accountNumber,
          accountType: model.accountType,
        );

        if (user.bankInfo == null || user.bankInfo!.isEmpty) {
          user.bankInfo = [bankInfo];
        } else {
          user.bankInfo![0] = bankInfo;
        }

        profileController.userData.value = user;

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
        "Something went wrong: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
