import 'package:get/get.dart';
import 'package:travell_booking_app/models/visitList/visit_list.dart';
import 'package:travell_booking_app/presentation/addmetting/meetingList/meeting_all/All_repository.dart';

import '../../../../core/helpers.dart';

class MeetingAllController extends GetxController {
  final AllRepository _allRepository = AllRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<VisitList> allMeetingList = <VisitList>[].obs;

  final RxBool isMoreDataAvailable = true.obs;
  int _currentPage = 1;
  final int _pageSize = 20;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isLoading.value || !isMoreDataAvailable.value) return;  // prevent duplicate calls

    if (isRefresh) {
      _currentPage = 1;
      allMeetingList.clear();
      isMoreDataAvailable.value = true;
    }

    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _allRepository.getVisitList(
        page: _currentPage,
        pageSize: _pageSize,
      );

      if (response.success && response.data != null && response.data!.isNotEmpty) {
        final newItems = response.data!.where((item) => !allMeetingList.contains(item)).toList();
        allMeetingList.addAll(newItems);

        if (newItems.isEmpty) {
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
    fetchUsers(isRefresh: true);
  }

  String getFirstAndLastLetter(String? name) {
    if (name == null || name.isEmpty) return '';
    if (name.length == 1) return name;
    return '${name[0]}${name[name.length - 1]}';
  }

  void cancelRequest() {
    _allRepository.cancelRequest();
  }
}
