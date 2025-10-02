import 'package:get/get.dart';
import 'package:travell_booking_app/models/home/home_page_view_builder_loader.dart';
import '../../core/helpers.dart';
import '../../models/User/user_models.dart';
import 'home_repository.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';


class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  final GetStorage storage = GetStorage();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<HomePageViewBuilderLoader> slider = <HomePageViewBuilderLoader>[].obs;
  final Rx<UserModels> userData = UserModels().obs;

  @override
  void onInit() {
    super.onInit();
    loadLocalData();
    fetchSlider();
    fetchDataUser();
  }

  /// Load stored data first
  void loadLocalData() {
    // Slider
    final sliderJson = storage.read('slider_data');
    if (sliderJson != null) {
      final List decoded = jsonDecode(sliderJson);
      slider.assignAll(decoded.map((e) => HomePageViewBuilderLoader.fromJson(e)).toList());
    }

    // User
    final userJson = storage.read('user_data');
    if (userJson != null) {
      final decoded = jsonDecode(userJson);
      userData.value = UserModels.fromJson(decoded);
    }
  }

  Future<void> fetchSlider() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _homeRepository.getSch();
      if (response.isNotEmpty) {
        slider.assignAll(response);
        storage.write('slider_data', jsonEncode(response.map((e) => e.toJson()).toList()));
      } else {
        hasError.value = true;
        errorMessage.value = "No slider data found";
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


  //  USER PROFILE API CALLING
  Future<void> fetchDataUser() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _homeRepository.getDataUser();
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

  void retry() {
    fetchSlider();
    fetchDataUser();
  }
}
