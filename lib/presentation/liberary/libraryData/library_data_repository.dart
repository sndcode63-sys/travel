
import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/librery/library_data.dart';

class LibraryDataRepository {
  final ApiServices _apiServices = ApiServices();

  Future<List<LibraryDataModel>> getLibraryList({required String schemeName, required String libraryHeadName }) async {
    return _apiServices.getList(
        ApiConstants1.libraryData,
            (json) => LibraryDataModel.fromJson(json),
        queryParameters: {'scheme_name': schemeName,'library_head_name': libraryHeadName}
    );
  }
}