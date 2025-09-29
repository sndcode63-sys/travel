import 'package:get/get.dart';
import '../../../models/librery/library_head.dart';
import 'library_head_repository.dart';



class LibraryHeadController extends GetxController {
  final LibraryHeadRepository _libraryHeadRepository = LibraryHeadRepository();

  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = "".obs;
  final RxList<LibraryHead1> livn = <LibraryHead1>[].obs;

  String? schemeId; // store scheme id

  @override
  void onInit() {
    super.onInit();
    schemeId = Get.arguments?['schemeId'];
    fetchLibraryHeads();
  }

  Future<void> fetchLibraryHeads() async {
    if (schemeId == null) {
      errorMessage.value = "Scheme ID is missing";
      return;
    }

    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = "";

      final response = await _libraryHeadRepository.getLibraryList(schemeId!);

      // Assign type to each item if null or empty
      for (var item in response) {
        item.type ??= getTypeFromName(item.name ?? '');
      }

      livn.assignAll(response);
      print('✅ Library heads loaded: ${livn.length}');
    } catch (e) {
      errorMessage.value = e.toString();
      print('❌ Error fetching library heads: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Helper to derive type from name
  String getTypeFromName(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('.pdf')) return 'pdf';
    if (lower.contains('.jpg') || lower.contains('.jpeg') || lower.contains('.png')) return 'image';
    if (lower.contains('.mp4') || lower.contains('.mov')) return 'video';
    if (lower.contains('.ppt') || lower.contains('.pptx')) return 'ppt';
    if (lower.contains('map') || lower.contains('location')) return 'location';
    return 'default';
  }

  String getFirstAndLastLetter(String? name) {
    if (name == null || name.isEmpty) return "";
    if (name.length == 1) return name;
    return "${name[0]}${name[name.length - 1]}";
  }
}
