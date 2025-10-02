import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travell_booking_app/models/visitList/visit_list.dart';

import '../../../../core/helpers.dart';
import 'All_repository.dart';

class VisitAllController extends GetxController {
  final AllRepository _allRepository = AllRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<VisitList> allMeetingList = <VisitList>[].obs;

  final RxBool isMoreDataAvailable = true.obs;
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isFetching = false;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers({bool loadMore = false}) async {
    if (_isFetching) return;

    _isFetching = true;
    if (!loadMore) {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";
      _currentPage = 1;
      isMoreDataAvailable.value = true;
    }

    try {
      final response = await _allRepository.getVisitList(
        page: _currentPage,
        pageSize: _pageSize,
      );

      if (loadMore) {
        allMeetingList.addAll(response);
      } else {
        allMeetingList.assignAll(response);
      }

      // Check if more data is available
      if (response.length < _pageSize) {
        isMoreDataAvailable.value = false;
      } else {
        _currentPage++;
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

  void retry() {
  }

  void cancelRequest() {
    _allRepository.cancelRequest();
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
