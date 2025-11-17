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

      print("📥 API Response verification statuses:");
      print("Email: ${response.emailVerifyStatus}");
      print("Phone: ${response.phoneVerifyStatus}");
      print("Aadhar: ${response.aadharVerifyStatus}");
      print("PAN: ${response.panVerifyStatus}");

      userData.value = response;

      // ✅ PRESERVE local verification statuses if API doesn't return them OR returns 0
      // If API returns 0 but we had 1 (verified) locally, keep the local value
      if ((response.emailVerifyStatus == null || response.emailVerifyStatus == 0) &&
          currentEmailStatus == 1) {
        userData.value.emailVerifyStatus = currentEmailStatus;
        print("✅ Preserved email verification status: $currentEmailStatus");
      }

      if ((response.phoneVerifyStatus == null || response.phoneVerifyStatus == 0) &&
          currentPhoneStatus == 1) {
        userData.value.phoneVerifyStatus = currentPhoneStatus;
        print("✅ Preserved phone verification status: $currentPhoneStatus");
      }

      if ((response.aadharVerifyStatus == null || response.aadharVerifyStatus == 0) &&
          currentAadharStatus == 1) {
        userData.value.aadharVerifyStatus = currentAadharStatus;
        print("✅ Preserved aadhar verification status: $currentAadharStatus");
      }

      if ((response.panVerifyStatus == null || response.panVerifyStatus == 0) &&
          currentPanStatus == 1) {
        userData.value.panVerifyStatus = currentPanStatus;
        print("✅ Preserved pan verification status: $currentPanStatus");
      }

      // ✅ Save to local storage
      storage.write('user_data', jsonEncode(userData.value.toJson()));
      print("✅ User data saved to cache");
      print("📊 Final verification statuses:");
      print("Email: ${userData.value.emailVerifyStatus}");
      print("Phone: ${userData.value.phoneVerifyStatus}");
      print("Aadhar: ${userData.value.aadharVerifyStatus}");
      print("PAN: ${userData.value.panVerifyStatus}");

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
      print("❌ Error fetching user data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ Public method for external refresh calls (alias for fetchDataUser)
  Future<void> refreshUserData() async {
    await fetchDataUser();
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

  // ✅ NEW: Update document information
  void updateDocumentData({
    String? aadharNumber,
    String? panNumber,
    String? passportNumber,
    String? reraCertificate,
    String? qualificationRemarks,
    String? policeVerificationCopy,
    String? bankCopyDocument,
    String? aadharImageSource,
    String? panImageSource,
    String? passportImageSource,
    String? qualificationRemarksImageSource,
    String? reraImageSource,
    String? policeVerificationImageSource,
    String? bankCopyImageSource,
  }) {
    userData.update((user) {
      if (user != null) {
        if (aadharNumber != null) user.aadharNumber = aadharNumber;
        if (panNumber != null) user.panNumber = panNumber;
        if (passportNumber != null) user.passportNumber = passportNumber;
        if (reraCertificate != null) user.reraCertificate = reraCertificate;
        if (qualificationRemarks != null) user.qualificationRemarks = qualificationRemarks;
        if (policeVerificationCopy != null) user.policeVerificationCopy = policeVerificationCopy;
        if (bankCopyDocument != null) user.bankCopyDocument = bankCopyDocument;

        if (aadharImageSource != null) user.aadharImageSource = aadharImageSource;
        if (panImageSource != null) user.panImageSource = panImageSource;
        if (passportImageSource != null) user.passportImageSource = passportImageSource;
        if (qualificationRemarksImageSource != null) user.qualificationRemarksImageSource = qualificationRemarksImageSource;
        if (reraImageSource != null) user.reraImageSource = reraImageSource;
        if (policeVerificationImageSource != null) user.policeVerificationImageSource = policeVerificationImageSource;
        if (bankCopyImageSource != null) user.bankCopyImageSource = bankCopyImageSource;

        // Save to local storage
        storage.write('user_data', jsonEncode(user.toJson()));
        print("✅ Document data updated and saved to cache");
      }
    });
  }

  // ✅ NEW: Mark documents as pending after submission
  void markDocumentsAsPending() {
    userData.update((user) {
      if (user != null) {
        user.aadharVerifyStatus = 2; // Pending
        user.panVerifyStatus = 2; // Pending

        // Save to local storage
        storage.write('user_data', jsonEncode(user.toJson()));
        print("✅ Documents marked as pending");
      }
    });
  }
}