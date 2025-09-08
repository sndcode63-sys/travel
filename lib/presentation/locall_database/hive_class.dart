import 'package:hive/hive.dart';

import 'local_database_related.dart';

class HiveService {
  static const String boxName = "distributor_retailer_box";

  Future<void> addDistributorRetailer(DistributorRetailerModel model) async {
    final box = await Hive.openBox<DistributorRetailerModel>(boxName);
    await box.add(model);
  }

  Future<List<DistributorRetailerModel>> getAll() async {
    final box = await Hive.openBox<DistributorRetailerModel>(boxName);
    return box.values.toList();
  }
}
