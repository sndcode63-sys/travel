import 'package:dio/dio.dart';
import 'package:travell_booking_app/core/constants/api_constants.dart';

import '../../../data/services/api_services.dart';
import '../../../models/associate/associate_list_model.dart';

class AssociateListRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<List<AssociateListModel>> getsVisitList({
    int page = 1,
    int pageSize = 10,
  }) async {
    _cancelToken = CancelToken();

    final queryParameters = {'page': page, 'page_size': pageSize};

    return await _apiServices.getList<AssociateListModel>(
      ApiConstants1.associateList,
      (data) => AssociateListModel.fromJson(data),
      queryParameters: queryParameters,
      cancelToken: _cancelToken,
    );
  }


  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}
