import 'package:get/get.dart';
import 'package:travell_booking_app/presentation/addVisit/repo.dart';
import '../../models/scheme/scheme_list_data.dart';
import '../../utlis/custom_widgets/customApiHeloer/custom_api_helper.dart';

class AddVisitController extends GetxController {
  final SchemeRepository _schemeRepository = SchemeRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;

  final RxList<SchemeListData> scheme = <SchemeListData>[].obs;
  final RxList<SchemeListData> filteredScheme = <SchemeListData>[].obs;
  final RxString searchQuery = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    ever(searchQuery, (_) => applySearch());
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _schemeRepository.getSch();

      if (response.success && response.data != null) {
        scheme.assignAll(response.data!);
        filteredScheme.assignAll(response.data!);
      } else {
        hasError.value = true;
        errorMessage.value = response.message;
        CustomNotifier.showPopup(message: response.message, isSuccess: false);
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'An unexpected error occurred';
      CustomNotifier.showPopup(message: errorMessage.value, isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }

  void applySearch() {
    if (searchQuery.value.isEmpty) {
      filteredScheme.assignAll(scheme);
    } else {
      final query = searchQuery.value.toLowerCase();
      filteredScheme.assignAll(
        scheme.where(
              (s) => s.schemeName?.toLowerCase().contains(query) ?? false,
        ),
      );
    }
  }

  String getFirstAndLastLetter(String? name) {
    if (name == null || name.isEmpty) return '';
    if (name.length == 1) return name;
    return '${name[0]}${name[name.length - 1]}';
  }
}
