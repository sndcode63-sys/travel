import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/librery/library_head.dart';



class LibraryHeadRepository {
  final ApiServices _apiServices = ApiServices();

  Future<List<LibraryHead1>> getLibraryList(String schemeId) async {
    return _apiServices.getList(
      ApiConstants1.libraryHeadList,
          (json) => LibraryHead1.fromJson(json),
      queryParameters: {'scheme_id': schemeId}
    );
  }
}
