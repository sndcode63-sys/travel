import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:travell_booking_app/models/scheme/scheme_list.dart';
import 'package:travell_booking_app/presentation/addVisit/repo.dart';

import '../../models/scheme/scheme_list_data.dart';



class AddVisitController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<SchemeListData> schemes = <SchemeListData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchemes();
  }

  void fetchSchemes() async {
    try {
      isLoading.value = true;
      final data = await SchemeRepository.instance.getSchemeList();
      schemes.assignAll(data); // update reactive list
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
