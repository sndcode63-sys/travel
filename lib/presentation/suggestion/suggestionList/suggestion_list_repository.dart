import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/suggestion/suggestion_get_List_model.dart';

class SuggestionListRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<List<SuggestionGetListModel>> getSuggestionList({
    int page = 1,
    int pageSize = 10,
  }) async {
    _cancelToken = CancelToken();

    final queryParameters = {
      'page': page,
      'page_size': pageSize,
    };

    return await _apiServices.getList<SuggestionGetListModel>(
      ApiConstants1.getSuggestionList,
          (data) => SuggestionGetListModel.fromJson(data),
      queryParameters: queryParameters,
      cancelToken: _cancelToken,
    );

  }
  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}
