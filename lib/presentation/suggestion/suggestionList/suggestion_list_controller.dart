import 'package:get/get.dart';

import '../../../core/helpers.dart';
import '../../../models/suggestion/suggestion_get_List_model.dart';
import 'suggestion_list_repository.dart';

import 'package:get/get.dart';
import '../../../core/helpers.dart';
import '../../../models/suggestion/suggestion_get_List_model.dart';
import 'suggestion_list_repository.dart';

class SuggestionListController extends GetxController {
  final SuggestionListRepository _repository = SuggestionListRepository();

  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = "".obs;

  var suggestionList = <SuggestionGetListModel>[].obs;

  // Pagination
  var isMoreDataAvailable = true.obs;
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isFetching = false;

  @override
  void onInit() {
    super.onInit();
    fetchSuggestions(); // initial fetch
  }

  Future<void> fetchSuggestions({bool loadMore = false}) async {
    if (_isFetching) return; // prevent multiple calls
    _isFetching = true;

    if (!loadMore) {
      // Initial load
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";
      _currentPage = 1;
      isMoreDataAvailable.value = true;
    }

    try {
      final response = await _repository.getSuggestionList(
        page: _currentPage,
        pageSize: _pageSize,
      );

      if (response.isEmpty) {
        if (!loadMore) {
          suggestionList.clear();
          hasError.value = true;
          errorMessage.value = "No suggestions found.";
        }
        isMoreDataAvailable.value = false;
      } else {
        if (loadMore) {
          suggestionList.addAll(response);
        } else {
          suggestionList.assignAll(response);
        }

        if (response.length < _pageSize) {
          isMoreDataAvailable.value = false;
        } else {
          _currentPage++;
        }
      }
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
      _isFetching = false;
    }
  }

  // Load more for pagination
  Future<void> loadMore() async {
    if (isMoreDataAvailable.value && !_isFetching) {
      await fetchSuggestions(loadMore: true);
    }
  }

  @override
  void onClose() {
    _repository.cancelRequest();
    super.onClose();
  }
}
