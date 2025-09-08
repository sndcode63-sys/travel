import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../locall_database/local_database_related.dart';
import '../locall_database/repository.dart';

import 'package:get/get.dart';

class ListDistributresController extends GetxController {
  final DistributorRetailerRepository _repo = DistributorRetailerRepository();
  RxList<DistributorRetailerModel> items = <DistributorRetailerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    items.value = _repo.getAllDistributorRetailers();
  }
}





class DistributorRetailerRepository {
  static const String boxName = "distributor_retailer_box";

  Future<void> addDistributorRetailer(DistributorRetailerModel model) async {
    final box = await Hive.openBox<DistributorRetailerModel>(boxName);
    await box.add(model);
  }

  /// ✅ Ye function list screen ke liye hai
  List<DistributorRetailerModel> getAllDistributorRetailers() {
    final box = Hive.box<DistributorRetailerModel>(boxName);
    return box.values.toList();
  }

  Future<void> deleteDistributorRetailer(int index) async {
    final box = Hive.box<DistributorRetailerModel>(boxName);
    await box.deleteAt(index);
  }

  Future<void> updateDistributorRetailer(int index, DistributorRetailerModel model) async {
    final box = Hive.box<DistributorRetailerModel>(boxName);
    await box.putAt(index, model);
  }
}
