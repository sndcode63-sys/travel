import 'package:get/get.dart';
import 'package:travell_booking_app/models/setting/support.dart';

import '../../../core/helpers.dart';
import 'help_support_repository.dart';



class HelpSupportController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final Rx<Support> support = Support().obs;

  final HelpSupportRepository _helpSupportRepository = HelpSupportRepository();

  @override
  void onInit() {
    super.onInit();
    fetchSupport();
  }

  Future<void> fetchSupport() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _helpSupportRepository.getSupportDetails();
      support.value = response;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'An unexpected error occurred';
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
    fetchSupport();
  }

  void cancelRequest() {
    _helpSupportRepository.cancelRequest();
  }
}
