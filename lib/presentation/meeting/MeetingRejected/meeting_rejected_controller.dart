import 'package:get/get.dart';

import '../../../models/meetingList/meeting_list.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../meeting_repository.dart';

class MeetingRejectedController extends GetxController {

  final  MeetingRepository _meetingRepository = MeetingRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final RxList<MeetingList> rejectedMeeting = <MeetingList>[].obs;

  final RxBool isMoreDataAvailable = true.obs;
  int _currentPage = 1;
  final int _pageSize = 20;
  bool _isFetching = false;

  @override
  void onInit() {
    super.onInit();
    fetchPendingMeetings();
  }

  Future<void> fetchPendingMeetings({bool isRefresh = false}) async {
    if (_isFetching) return;

    _isFetching = true;

    if (isRefresh) {
      _currentPage = 1;
      rejectedMeeting.clear();
      isMoreDataAvailable.value = true;
      hasError.value = false;
      errorMessage.value = "";
    }

    if (!isRefresh && !isMoreDataAvailable.value) {
      _isFetching = false;
      return;
    }

    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _meetingRepository.getVisitList(
        page: _currentPage,
        pageSize: _pageSize,
      );

      // Filter only approved meetings
      final newApproved = response
          .where((item) =>
      item.visitStatus?.toLowerCase() == "pending" &&
          !rejectedMeeting.any((e) => e.id == item.id))
          .toList();

      // Add new items
      rejectedMeeting.addAll(newApproved);

      // Check if more data is available
      if (newApproved.length < _pageSize) {
        isMoreDataAvailable.value = false;
      } else {
        _currentPage++;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'An unexpected error occurred';
      CustomNotifier.showPopup(message: errorMessage.value, isSuccess: false);
    } finally {
      isLoading.value = false;
      _isFetching = false;
    }
  }

  void retry() {
  }

  void cancelRequest() {
    _meetingRepository.cancelRequest();
  }
}
