import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers.dart';
import '../../../models/vehicle/vehicle_list.dart';
import 'vehicle_repository.dart';


class VehicleController extends GetxController {
  final VehicleRepositorys _vehicleRepositorys = VehicleRepositorys();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<VehicleList> allMeeting = <VehicleList>[].obs;

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
      final response = await _vehicleRepositorys.getVisitList(
        page: _currentPage,
        pageSize: _pageSize,
      );

      if (response.isEmpty) {
        if (!loadMore) {
          allMeeting.clear();
          hasError.value = true;
          errorMessage.value = "No data found.";
        }
        isMoreDataAvailable.value = false;
      } else {
        if (loadMore) {
          allMeeting.addAll(response);
        } else {
          allMeeting.assignAll(response);
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

  void cancelRequest() => _vehicleRepositorys.cancelRequest();

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

extension VehicleControllerDelete on VehicleController {
  void deleteVehicle(String vehicleId) async {
    try {
      isLoading.value = true;

      bool success = await _vehicleRepositorys.deleteVehicle(vehicleId);

      if (success) {
        allMeeting.removeWhere((element) => element.id == vehicleId);

        AppHelpers.showSnackBar(
          title: "Success",
          message: "Vehicle deleted successfully",
          isError: false,
        );
      } else {
        AppHelpers.showSnackBar(
          title: "Failed",
          message: "Unable to delete vehicle",
          isError: true,
        );
      }
    } catch (e) {
      AppHelpers.showSnackBar(
        title: "Error",
        message: e.toString(),
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

extension VehicleControllerUpdate on VehicleController {
  void updateVehicleStatus(String vehicleId, bool isOn) async {
    try {
      isLoading.value = true;

      bool success = await _vehicleRepositorys.changeVehicleStatus(vehicleId, isOn);

      if (success) {
        final vehicle = allMeeting.firstWhere((v) => v.id == vehicleId);
        vehicle.isOn.value = isOn;

        AppHelpers.showSnackBar(
          title: "Success",
          message: "Vehicle status updated successfully",
          isError: false,
        );
      } else {
        AppHelpers.showSnackBar(
          title: "Failed",
          message: "Unable to update vehicle status",
          isError: true,
        );
      }
    } catch (e) {
      AppHelpers.showSnackBar(
        title: "Error",
        message: e.toString(),
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

