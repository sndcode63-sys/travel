import 'package:get/get.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../../addVisit/repo.dart';


class EnterSummaryController extends GetxController {
  final disputeReasonController = SingleValueDropDownController();
  final projectNameController = SingleValueDropDownController();
  final plotNameController = SingleValueDropDownController();

  final SchemeRepository schemeRepository = SchemeRepository();

  Rx<DropDownValueModel?> disputeReason = Rx<DropDownValueModel?>(null);
  Rx<DropDownValueModel?> projectName = Rx<DropDownValueModel?>(null);
  Rx<DropDownValueModel?> plotName = Rx<DropDownValueModel?>(null);

  RxList<DropDownValueModel> projectList = <DropDownValueModel>[].obs;
  RxBool isProjectLoading = false.obs;

  void onDisputeReasonSelected(DropDownValueModel? val) {
    disputeReason.value = val;

    if (val?.value == 'Plot') {
      fetchProjectList();
    } else {
      projectList.clear();
      projectName.value = null;
      plotName.value = null;
    }
  }

  Future<void> fetchProjectList() async {
    try {
      isProjectLoading.value = true;
      final response = await schemeRepository.getSch();
      projectList.value = response
          .map((scheme) => DropDownValueModel(
        name: scheme.schemeName ?? "Unnamed",
        value: scheme.schemeId.toString(),
      ))
          .toList();
    } catch (e) {
      print("Error fetching project list: $e");
      Get.snackbar("Error", "Failed to load project list");
    } finally {
      isProjectLoading.value = false;
    }
  }

  void onProjectNameSelected(DropDownValueModel? val) {
    projectName.value = val;
  }

  void onPlotNameSelected(DropDownValueModel? val) {
    plotName.value = val;
  }

  @override
  void onClose() {
    disputeReasonController.dispose();
    projectNameController.dispose();
    plotNameController.dispose();
    super.onClose();
  }
}
