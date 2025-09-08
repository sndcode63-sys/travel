import 'hive_class.dart';
import 'local_database_related.dart';

class DistributorRetailerRepository {
  final HiveService _hiveService = HiveService();

  Future<void> addDistributorRetailer(DistributorRetailerModel model) =>
      _hiveService.addDistributorRetailer(model);

  Future<List<DistributorRetailerModel>> getAll() => _hiveService.getAll();
}
