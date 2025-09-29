import 'package:get/get.dart';

import '../../core/helpers.dart';
import '../../models/librery/liberery_list.dart';
import 'library_repository.dart';

class LibraryController extends GetxController {
  final LibraryRepository _libraryRepository = LibraryRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<LibreryList>livn = <LibreryList>[].obs;

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


      final response = await _libraryRepository.getLibraryList();

      print('📥 Response from Repository has ${response.length} items');

      livn.assignAll(response);

      print('✅ List assigned. livn now has ${livn.length} items');

      livn.forEach((scheme) {
        print('   -> Scheme: ${scheme.name}');
      });


    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

}
