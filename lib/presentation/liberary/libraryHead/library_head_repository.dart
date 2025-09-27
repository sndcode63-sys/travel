import 'package:dio/dio.dart';
import 'package:travell_booking_app/models/librery/library_head.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/librery/liberery_list.dart';

class LibraryHeadRepository {
  final ApiServices _apiServices = ApiServices();

  Future<List<LibraryHead>> getLibraryList() async {
    return await _apiServices.getList<LibraryHead>(
      ApiConstants1.libraryHeadList,
          (json) => LibraryHead.fromJson(json),
    );
  }
}
