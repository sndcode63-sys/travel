import 'package:get/get.dart';
import '../../../core/helpers.dart';
import '../../../models/team/all_downline_list_model.dart';
import 'all_downline_repository.dart';

class AllDownlineController extends GetxController {
  final AllDownlineRepository _allDownlineRepository = AllDownlineRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final RxList<AllDownlineListModel> allDownline = <AllDownlineListModel>[].obs;
  final RxList<AllDownlineListModel> filteredSelf = <AllDownlineListModel>[].obs;

  final RxString searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    // Trigger filtering when search query changes
    ever(searchQuery, (_) => applySearch());
  }

  // Apply Search Filter
  void applySearch() {
    final query = searchQuery.value.toLowerCase().trim();
    if (query.isEmpty) {
      filteredSelf.assignAll(allDownline);
    } else {
      filteredSelf.assignAll(
        allDownline.where((s) =>
        (s.name?.toLowerCase().contains(query) ?? false) ||
            (s.id?.toString().contains(query) ?? false)),
      );
    }
  }

  // Helper: Get initials
  String getFirstAndLastLetter(String? name) {
    if (name == null || name.isEmpty) return "";
    return name.length == 1 ? name : "${name[0]}${name[name.length - 1]}";
  }

  // Fetch Downline Users
  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _allDownlineRepository.getSefList();
      allDownline.assignAll(response);
      filteredSelf.assignAll(response);
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
}
