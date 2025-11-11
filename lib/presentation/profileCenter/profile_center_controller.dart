import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/helpers.dart';
import '../../models/associate/associate_details_get.dart';
import 'repository_profile_centre.dart';

class ProfileCenterController extends GetxController {
  final RepositoryProfileCentre _repositoryProfileCentre = RepositoryProfileCentre();
  final GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final Rx<AssociateDetailsGet> userData = AssociateDetailsGet().obs;

  @override
  void onInit() {
    super.onInit();
    loadLocalData();
    fetchDataUser();
  }

  void loadLocalData() {
    try {
      final cachedData = storage.read('user_data');
      if (cachedData != null) {
        final Map<String, dynamic> json = jsonDecode(cachedData);
        userData.value = AssociateDetailsGet.fromJson(json);
        print("✅ Loaded user data from cache");
        print("📊 Email Status: ${userData.value.emailVerifyStatus}");
        print("📊 Phone Status: ${userData.value.phoneVerifyStatus}");
        print("📊 Aadhar Status: ${userData.value.aadharVerifyStatus}");
        print("📊 PAN Status: ${userData.value.panVerifyStatus}");
      }
    } catch (e) {
      print("⚠️ Error loading cached data: $e");
    }
  }

  Future<void> fetchDataUser() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final currentEmailStatus = userData.value.emailVerifyStatus;
      final currentPhoneStatus = userData.value.phoneVerifyStatus;
      final currentAadharStatus = userData.value.aadharVerifyStatus;
      final currentPanStatus = userData.value.panVerifyStatus;

      print("📦 Current verification statuses before API:");
      print("Email: $currentEmailStatus");
      print("Phone: $currentPhoneStatus");
      print("Aadhar: $currentAadharStatus");
      print("PAN: $currentPanStatus");

      final response = await _repositoryProfileCentre.getAssociateUser();
      userData.value = response;

      // ✅ PRESERVE local verification statuses if API doesn't return them
      if (response.emailVerifyStatus == null && currentEmailStatus != null) {
        userData.value.emailVerifyStatus = currentEmailStatus;
        print("✅ Preserved email verification status: $currentEmailStatus");
      }
      if (response.phoneVerifyStatus == null && currentPhoneStatus != null) {
        userData.value.phoneVerifyStatus = currentPhoneStatus;
        print("✅ Preserved phone verification status: $currentPhoneStatus");
      }
      if (response.aadharVerifyStatus == null && currentAadharStatus != null) {
        userData.value.aadharVerifyStatus = currentAadharStatus;
        print("✅ Preserved aadhar verification status: $currentAadharStatus");
      }
      if (response.panVerifyStatus == null && currentPanStatus != null) {
        userData.value.panVerifyStatus = currentPanStatus;
        print("✅ Preserved pan verification status: $currentPanStatus");
      }

      // ✅ Save to local storage
      storage.write('user_data', jsonEncode(userData.value.toJson()));
      print("✅ User data saved to cache");

      // ✅ Force UI refresh
      userData.refresh();

    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to fetch user data';
      AppHelpers.showSnackBar(
        title: "Error",
        message: errorMessage.value,
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void markAsVerified(String type) {
    updateVerificationStatus(type, 1);
    userData.refresh();
    print("🎯 $type marked as verified and UI refreshed");
  }


  // ✅ Method to update verification status locally
  void updateVerificationStatus(String type, int status) {
    userData.update((user) {
      if (user != null) {
        switch (type) {
          case "Email":
            user.emailVerifyStatus = status;
            print("✅ Updated email verification status to: $status");
            break;
          case "Aadhar":
            user.aadharVerifyStatus = status;
            print("✅ Updated aadhar verification status to: $status");
            break;
          case "PAN":
            user.panVerifyStatus = status;
            print("✅ Updated PAN verification status to: $status");
            break;
          case "Phone":
            user.phoneVerifyStatus = status;
            print("✅ Updated phone verification status to: $status");
            break;
        }
        // Save to local storage
        storage.write('user_data', jsonEncode(user.toJson()));
        print("✅ Verification status saved to cache");
      }
    });
  }
}