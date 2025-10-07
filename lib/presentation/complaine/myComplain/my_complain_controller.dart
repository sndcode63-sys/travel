import 'package:get/get.dart';

import '../../../core/helpers.dart';
import '../../../models/complain/staff_search.dart';
import 'repository.dart';

class MyComplainController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool hasSearched = false.obs;
  RxBool hasData = false.obs;

  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final RxList<StaffSearch> searchResults = <StaffSearch>[].obs;
  final Repository _repository = Repository();


  void searchData(String query) async {
    hasSearched.value = true;

    if (query.trim().length < 3) {
      searchResults.clear();
      hasData.value = false;
      return;
    }

    isLoading.value = true;

    try {
      final results = await _repository.searchUsers(searchText: query);
      searchResults.assignAll(results);
      hasData.value = searchResults.isNotEmpty;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = "Something went wrong";
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
