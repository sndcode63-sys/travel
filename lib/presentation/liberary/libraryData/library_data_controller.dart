import 'package:get/get.dart';
import 'package:travell_booking_app/models/librery/library_data.dart';
import 'library_data_repository.dart';

class LibraryDataController extends GetxController {
  final LibraryDataRepository _libraryDataRepository = LibraryDataRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<LibraryDataModel> livn = <LibraryDataModel>[].obs;
  // RxString schemeName = ''.obs;
  // RxString libraryHeadName = ''.obs;

  String? schemeId;
  String? schemeName;
  String? libraryHeadName;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    schemeId = args?['schemeId'];
    schemeName = args?['scheme_name'];
    libraryHeadName = args?['library_head_name'];

    fetchLibraryHeads();
  }

  Future<void> fetchLibraryHeads() async {
    if (schemeName == null) {
      errorMessage.value = "Scheme ID is missing";
      return;
    }
    if (libraryHeadName == null) {
      errorMessage.value = "Library Head Name is missing";
      return;
    }

    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _libraryDataRepository.getLibraryList(
        schemeName: schemeName.toString(),
        libraryHeadName: libraryHeadName.toString(),
      );
      livn.assignAll(response);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  String getFirstAndLastLetter(String? name) {
    if (name == null || name.isEmpty) return "";
    if (name.length == 1) return name;
    return "${name[0]}${name[name.length - 1]}";
  }
}
