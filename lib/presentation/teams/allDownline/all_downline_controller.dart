import 'package:get/get.dart';

import '../../../core/helpers.dart';
import '../../../models/team/all_downline_list_model.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
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
    if (name == null || name.isEmpty) return "";

    if (name.length == 1) return name;

    return "${name[0]}${name[name.length - 1]}";
  }


  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _allDownlineRepository.getSefList();

      if (response.success && response.data != null) {
        allDownline.assignAll(response.data!);
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
        CustomNotifier.showPopup(message: response.message, isSuccess: false);

      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'An unexpected error occurred';
      CustomNotifier.showPopup(message: errorMessage.value, isSuccess: false);

    } finally {
      isLoading.value = false;
    }

    void retry() {
      fetchUsers();
    }
  }
}
