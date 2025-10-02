import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/teams/self_download/self_repository.dart';

import '../../../core/helpers.dart';
import '../../../models/team/team_self_model.dart';



class SelfController extends GetxController {
  final SelfRepository _selfRepository = SelfRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<TeamSelfModel> selfListGet = <TeamSelfModel>[].obs;
  final RxList<TeamSelfModel> filteredSelf = <TeamSelfModel>[].obs;
  final RxString searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    ever(searchQuery, (_) => applySearch());
  }

  /// 🔍 Search
  void applySearch() {
    if (searchQuery.value.isEmpty) {
      filteredSelf.assignAll(selfListGet);
    } else {
      final query = searchQuery.value.toLowerCase();
      filteredSelf.assignAll(
        selfListGet.where(
              (s) => (s.name.toLowerCase().contains(query)),
        ),
      );
    }
  }

  String getFirstAndLastLetter(String? name) {
    if (name == null || name.isEmpty) return '';
    if (name.length == 1) return name;
    return '${name[0]}${name[name.length - 1]}'; // ✅ fixed (पहले -9 था)
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _selfRepository.getSefList();

      selfListGet.assignAll(response);
      filteredSelf.assignAll(response); // ✅ copy for search

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
    fetchUsers();
  }
}
