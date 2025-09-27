
import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/response_model.dart';
import '../../data/services/api_services.dart';
import '../../models/scheme/scheme_list_data.dart';


class SchemeRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<List<SchemeListData>> getSch() async {
    _cancelToken = CancelToken();

    return await _apiServices.getList<SchemeListData>(
      ApiConstants1.schemeList,
          (data) => SchemeListData.fromJson(data),
      cancelToken: _cancelToken,
    );
  }

  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}

