import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../data/services/api_services.dart';
import '../../models/librery/liberery_list.dart';

class LibraryRepository {
  final ApiServices _apiServices = ApiServices();

  Future<List<LibreryList>> getLibraryList() async {
    return await _apiServices.getList<LibreryList>(
      ApiConstants1.libraryList,
          (json) => LibreryList.fromJson(json),
    );
  }
}
