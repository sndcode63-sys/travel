import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helpers.dart';
import '../../../models/vehicle/vehicle_list.dart';
import '../vehicleList/vehicle_repository.dart';

abstract class BaseVehicleController extends GetxController {
  final VehicleRepositorys repo = VehicleRepositorys();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<VehicleList> allMeeting = <VehicleList>[].obs;

  final RxBool isMoreDataAvailable = true.obs;
  int page = 1;
  final int pageSize = 10;
  bool _fetching = false;

  /// → Override in child controllers
  String? filterStatus();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers({bool loadMore = false}) async {
    if (_fetching) return;
    _fetching = true;

    if (!loadMore) {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';
      page = 1;
      isMoreDataAvailable.value = true;
    }

    try {
      final data = await repo.getVisitList(page: page, pageSize: pageSize);

      if (data.isEmpty) {
        if (!loadMore) {
          allMeeting.clear();
          hasError.value = true;
          errorMessage.value = 'No data found.';
        }
        isMoreDataAvailable.value = false;
      } else {
        // Apply Status Filter
        final status = filterStatus();
        final filtered = status == null
            ? data
            : data.where((e) => (e.visitStatus ?? '').toLowerCase() == status).toList();

        if (loadMore) {
          allMeeting.addAll(filtered);
        } else {
          allMeeting.assignAll(filtered);
        }

        if (filtered.length < pageSize) {
          isMoreDataAvailable.value = false;
        } else {
          page++;
        }
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Unexpected error occurred';
      AppHelpers.showSnackBar(
        title: "Error",
        message: "$e",
        isError: true,
      );
    } finally {
      isLoading.value = false;
      _fetching = false;
    }
  }

  void cancelRequest() => repo.cancelRequest();

  // Common delete
  Future<void> deleteVehicle(String id) async {
    try {
      isLoading.value = true;

      final ok = await repo.deleteVehicle(id);

      if (ok) {
        allMeeting.removeWhere((v) => v.id == id);
        AppHelpers.showSnackBar(title: "Success", message: "Vehicle Deleted");
      } else {
        AppHelpers.showSnackBar(title: "Failed", message: "Delete failed", isError: true);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Common update switch
  Future<void> updateVehicleStatus(String id, bool isOn) async {
    try {
      final vehicle = allMeeting.firstWhere((v) => v.id == id);
      final old = vehicle.isOn.value;

      vehicle.isOn.value = isOn;
      vehicle.active = isOn ? 1 : 0;

      final ok = await repo.changeVehicleStatus(id, isOn);

      if (!ok) {
        vehicle.isOn.value = old;
        vehicle.active = old ? 1 : 0;
        AppHelpers.showSnackBar(title: "Failed", message: "Unable to update", isError: true);
      }
    } catch (e) {
      AppHelpers.showSnackBar(title: "Error", message: "$e", isError: true);
    }
  }
}
