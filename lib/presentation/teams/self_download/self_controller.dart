import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/teams/self_download/self_repository.dart';

import '../../../core/helpers.dart';
import '../../../models/team/team_self_model.dart';

class SelfController extends GetxController {
  final SelfRepository _selfRepository = SelfRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<TeamSelfModel>selfListGEt = <TeamSelfModel>[].obs;

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

      final responce = await _selfRepository.getSefList();

      if (responce.success && responce.data != null) {
        selfListGEt.assignAll(responce.data!);
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
