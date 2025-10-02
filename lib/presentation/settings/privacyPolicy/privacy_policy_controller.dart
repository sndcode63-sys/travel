import 'package:get/get.dart';
import '../../../core/helpers.dart';
import '../../../models/setting/privacy_model.dart';
import 'privacy_policy_repository.dart';

class PrivacyPolicyController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final Rx<PrivacyModel> privacyData = PrivacyModel().obs;

  final PrivacyPolicyRepository _repository = PrivacyPolicyRepository();

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _repository.getPrivacyPolicy();
      privacyData.value = response;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to fetch privacy policy';
      AppHelpers.showSnackBar(
        title: "Error",
        message: errorMessage.value,
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void retry() {
    fetchPrivacyPolicy();
  }

  void cancelRequest() {
    _repository.cancelRequest();
  }
}
