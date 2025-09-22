import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/models/meetingList/meeting_list.dart';
import 'package:travell_booking_app/presentation/meeting/meeting_repository.dart';

import '../../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';

class MeetingAllContoroller extends GetxController {
  final MeetingRepository _meetingRepository = MeetingRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<MeetingList> allMeeting = <MeetingList>[].obs;

  final RxBool isMoreDataAvailable = true.obs;
  int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isLoading.value || !isMoreDataAvailable.value) return;

    if (isRefresh) {
      _currentPage = 1;
      allMeeting.clear();
      isMoreDataAvailable.value = true;
    }

    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _meetingRepository.getVisitList(
        page: _currentPage,
        pageSize: _pageSize,
      );

      if (response.success && response.data != null && response.data!.isNotEmpty) {
        // Duplicate prevention using ID check
        final newItems = response.data!
            .where((item) => !allMeeting.any((e) => e.id == item.id))
            .toList();

        allMeeting.addAll(newItems);

        if (newItems.isEmpty || newItems.length < _pageSize) {
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
    fetchUsers(isRefresh: true);
  }

  void cancelRequest() {
    _meetingRepository.cancelRequest();
  }


  Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

}
