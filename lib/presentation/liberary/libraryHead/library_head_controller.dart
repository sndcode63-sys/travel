import 'package:get/get.dart';

import '../../../core/helpers.dart';
import 'library_head.dart';
import 'library_head_repository.dart';

class LibraryHeadController extends GetxController {
  final LibraryHeadRepository _libraryHeadRepository = LibraryHeadRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<LibraryHead>livn = <LibraryHead>[].obs;

  @override
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  String getFirstAndLastLetter(String? name) {
    if (name == null || name.isEmpty) return "";

    if (name.length == 1) return name;

    return "${name[0]}${name[name.length - 1]}";
  }


  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      // final response = await _libraryRepository.getLibraryList();
      //
      // livn.assignAll(response);
      // // filteredSelf.assignAll(response); /
      final response = await _libraryHeadRepository.getLibraryList();
      print("Fetched users: ${response.length}");
      // livn.assignAll(response);


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
