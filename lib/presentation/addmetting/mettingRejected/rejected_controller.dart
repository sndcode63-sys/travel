import 'package:get/get.dart';

import '../../../core/helpers.dart';
import '../../../models/visitList/visit_list.dart';
import '../meetingList/meeting_all/All_repository.dart';

class RejectedController extends GetxController {
  final AllRepository _repository = AllRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final RxList<VisitList> pendingMeetingList = <VisitList>[].obs;

  final RxBool isMoreDataAvailable = true.obs;
  int _currentPage = 1;
  final int _pageSize = 20;

  @override
  void onInit() {
    super.onInit();
    fetchPendingMeetings();
  }

  Future<void> fetchPendingMeetings({bool isRefresh = false}) async {
    if (isLoading.value || !isMoreDataAvailable.value) return;

    if (isRefresh) {
      _currentPage = 1;
      pendingMeetingList.clear();
      isMoreDataAvailable.value = true;
    }

    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _repository.getVisitList(
        page: _currentPage,
        pageSize: _pageSize,
      );

      if (response.success && response.data != null && response.data!.isNotEmpty) {
        final newPending = response.data!
            .where((item) =>
        item.visitStatus?.toLowerCase() == "rejected" &&
            !pendingMeetingList.any((e) => e.id == item.id))
            .toList();

        pendingMeetingList.addAll(newPending);

        if (newPending.length < _pageSize) {
          isMoreDataAvailable.value = false;
        } else {
          _currentPage++;
        }
      } else {
        isMoreDataAvailable.value = false;
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
    }
  }

  void retry() {
    fetchPendingMeetings(isRefresh: true);
  }

  void cancelRequest() {
    _repository.cancelRequest();
  }
}
