import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers.dart';
import '../../../models/vehicle/vehicle_list.dart';
import '../vehicleList/vehicle_controller.dart';
import '../vehicleList/vehicle_repository.dart';

class ApprovedController extends GetxController {
  final VehicleRepositorys _vehicleRepository = VehicleRepositorys();

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
      final response = await _vehicleRepository.getVisitList(
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
        // Filter only approved vehicles
        final approvedList = response
            .where((item) => item.visitStatus?.toLowerCase() == "approved")
            .toList();

        if (loadMore) {
          allMeeting.addAll(approvedList);
        } else {
          allMeeting.assignAll(approvedList);
        }

        if (approvedList.length < _pageSize) {
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

  void cancelRequest() => _vehicleRepository.cancelRequest();

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

extension VehicleControllerDelete on ApprovedController {
  void deleteVehicle(String vehicleId) async {
    try {
      isLoading.value = true;

      bool success = await _vehicleRepository.deleteVehicle(vehicleId);

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

extension VehicleControllerUpdate on ApprovedController {
  void updateVehicleStatus(String vehicleId, bool isOn) async {
    try {
      // Show loading but don't block the UI
      final vehicle = allMeeting.firstWhere((v) => v.id == vehicleId);
      final previousState = vehicle.isOn.value;

      // Optimistically update UI
      vehicle.isOn.value = isOn;
      vehicle.active = isOn ? 1 : 0;

      bool success = await _vehicleRepository.changeVehicleStatus(vehicleId, isOn);

      if (success) {
        AppHelpers.showSnackBar(
          title: "Success",
          message: "Vehicle status updated successfully",
          isError: false,
        );
      } else {
        // Revert on failure
        vehicle.isOn.value = previousState;
        vehicle.active = previousState ? 1 : 0;

        AppHelpers.showSnackBar(
          title: "Failed",
          message: "Unable to update vehicle status",
          isError: true,
        );
      }
    } catch (e) {
      // Revert on error
      final vehicle = allMeeting.firstWhere((v) => v.id == vehicleId);
      vehicle.isOn.value = !isOn;
      vehicle.active = !isOn ? 1 : 0;

      AppHelpers.showSnackBar(
        title: "Error",
        message: e.toString(),
        isError: true,
      );
    }
  }
}

extension ApprovedFiltering on ApprovedController {
  List<VehicleList> getFilteredVehicles(String query) {
    if (query.isEmpty) return allMeeting;

    return allMeeting.where((vehicle) {
      final regNumber = vehicle.registrationNumber?.toLowerCase() ?? '';
      final model = vehicle.modelName?.toLowerCase() ?? '';
      final brand = vehicle.brandName?.toLowerCase() ?? '';
      final color = vehicle.color?.toLowerCase() ?? '';

      return regNumber.contains(query) ||
          model.contains(query) ||
          brand.contains(query) ||
          color.contains(query);
    }).toList();
  }
}