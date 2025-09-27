import 'package:get/get.dart';
import 'package:travell_booking_app/models/home/home_page_view_builder_loader.dart';

import '../../core/helpers.dart';
import 'home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<HomePageViewBuilderLoader>slider = <HomePageViewBuilderLoader>[].obs;

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

      final response = await _homeRepository.getSch();

      if (response.isNotEmpty) {
        slider.assignAll(response);
      } else {
        hasError.value = true;
        errorMessage.value = "No data found";
        AppHelpers.showSnackBar(
          title: "Error",
          message: errorMessage.value,
          isError: true,
        );
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
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
    fetchUsers();
  }
}
