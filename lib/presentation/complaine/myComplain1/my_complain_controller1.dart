import 'package:get/get.dart';

import '../../../core/helpers.dart';
import '../../../models/complain/get_dispute.dart';
import 'repository1.dart';

class MyComplainController1 extends GetxController {
  RxBool isLoading = false.obs;
  RxBool hasData = false.obs;

  RxList<Data> disputeList = <Data>[].obs;

  final Repository1 _repository = Repository1();

  @override
  void onInit() {
    super.onInit();
    fetchMyDisputeList();
  }
  // POST SE GET LIST KARNA

  void fetchMyDisputeList() async {
    isLoading.value = true;
    try {
      final list = await _repository.getMyDisputeList();
      disputeList.assignAll(list);
      hasData.value = disputeList.isNotEmpty;
    } catch (e) {
      AppHelpers.showSnackBar(
        title: "Error",
        message: "Unable to load dispute list",
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
