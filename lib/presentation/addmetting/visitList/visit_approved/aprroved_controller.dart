import 'package:get/get.dart';
import '../../../../models/visitList/visit_list.dart';
import '../../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../visit_all/All_repository.dart';

class AprrovedController extends GetxController {

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
        item.visitStatus?.toLowerCase() == "approved" &&
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
      CustomNotifier.showPopup(message: errorMessage.value, isSuccess: false);

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
