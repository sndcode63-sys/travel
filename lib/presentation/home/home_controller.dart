import 'dart:convert';

import 'package:get/get.dart';
import 'package:travell_booking_app/models/home/home_page_view_builder_loader.dart';
import '../../core/helpers.dart';
import '../../models/User/user_models.dart';
import 'home_repository.dart';
import 'package:get_storage/get_storage.dart';



class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  final GetStorage storage = GetStorage();

  // Reactive user data
  final Rx<UserModels> userData = UserModels().obs;

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<HomePageViewBuilderLoader> slider = <HomePageViewBuilderLoader>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLocalData();
    fetchSlider();
  }

  void loadLocalData() {
    // Slider
    final sliderJson = storage.read('slider_data');
    if (sliderJson != null) {
      List decoded;
      if (sliderJson is String) {
        decoded = jsonDecode(sliderJson);
      } else if (sliderJson is List) {
        decoded = sliderJson;
      } else {
        decoded = [];
      }
      slider.assignAll(decoded.map((e) => HomePageViewBuilderLoader.fromJson(e)).toList());
    }

    // User
    final userStored = storage.read('user_data');
    if (userStored != null) {
      if (userStored is String) {
        userData.value = UserModels.fromJson(jsonDecode(userStored));
      } else if (userStored is Map<String, dynamic>) {
        userData.value = UserModels.fromJson(userStored);
      }
    }
  }

  /// Fetch slider from API
  Future<void> fetchSlider() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _homeRepository.getSch();
      if (response.isNotEmpty) {
        slider.assignAll(response);
        storage.write('slider_data', response.map((e) => e.toJson()).toList());
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

  // Update userData both locally & reactive
  void updateUser(UserModels updatedUser) {
    userData.value = updatedUser;
    storage.write('user_data', updatedUser.toJson());
  }

  void retry() {
    fetchSlider();
  }
}
