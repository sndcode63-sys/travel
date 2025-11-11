import 'package:get/get.dart';
import '../../../models/associate/associate_list_model.dart';
import '../../../models/visitList/visit_list.dart';
import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';
import '../associtateList/associate_list_repository.dart';

class AssociateRejectedController extends GetxController {
  final AssociateListRepository _associateListRepository = AssociateListRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final RxList<AssociateListModel> rejectedAssociateList = <AssociateListModel>[].obs;

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
      rejectedAssociateList.clear();
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

      final response = await _associateListRepository.getsVisitList(
        page: _currentPage,
        pageSize: _pageSize,
      );

      final newApproved = response
          .where((item) =>
      item.active?.toLowerCase() == "rejected" &&
          !rejectedAssociateList.any((e) => e.id == item.id))
          .toList();

      rejectedAssociateList.addAll(newApproved);

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
    fetchPendingMeetings(isRefresh: true);
  }

  void cancelRequest() {
    _associateListRepository.cancelRequest();
  }
}
