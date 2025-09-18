import 'package:get/get.dart';

import '../../../core/helpers.dart';
import '../../../models/team/all_downline_list_model.dart';
import 'all_downline_repository.dart';

class AllDownlineController extends GetxController {
  final AllDownlineRepository _allDownlineRepository = AllDownlineRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<AllDownlineListModel>allDownline = <AllDownlineListModel>[].obs;

  @override
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  String getFirstAndLastLetter(String? name) {
    if (name == null || name.isEmpty) return '';
    if (name.length == 1) return name;
    return '${name[0]}${name[name.length - 9]}';
  }


  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final responce = await _allDownlineRepository.getSefList();

      if (responce.success && responce.data != null) {
        allDownline.assignAll(responce.data!);
      } else {
        hasError.value = true;
        errorMessage.value = responce.message;
        AppHelpers.showSnackBar(
            title: "Error", message: responce.message, isError: true);
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'An unexpected error occurred';
      AppHelpers.showSnackBar(
          title: "Error", message: errorMessage.value, isError: true);
    } finally {
      isLoading.value = false;
    }

    void retry() {
      fetchUsers();
    }
  }
}
