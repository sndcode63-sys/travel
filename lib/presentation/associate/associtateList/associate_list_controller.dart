import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers.dart';
import '../../../models/associate/associate_list_model.dart';
import 'associate_list_repository.dart';

class AssociateListController extends GetxController {
  final AssociateListRepository _associateListRepository = AssociateListRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<AssociateListModel> allAssociateList = <AssociateListModel>[].obs;

  final RxBool isMoreDataAvailable = true.obs;
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _isFetching = false;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser({bool loadMore = false}) async {
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
      final response = await _associateListRepository.getsVisitList(
        page: _currentPage,
        pageSize: _pageSize,
      );

      if (response.isEmpty) {
        if (!loadMore) {
          allAssociateList.clear();
          hasError.value = true;
          errorMessage.value = "No data found.";
        }
        isMoreDataAvailable.value = false;
      } else {
        if (loadMore) {
          allAssociateList.addAll(response);
        } else {
          allAssociateList.assignAll(response);
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

  void cancelRequest() => _associateListRepository.cancelRequest();

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
