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
    // loadLocalData();
    fetchDataUser();
  }



  Future<void> fetchDataUser() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _repositoryProfileCentre.getAssociateUser();
      userData.value = response;
      storage.write('user_data', jsonEncode(response.toJson()));
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

}
