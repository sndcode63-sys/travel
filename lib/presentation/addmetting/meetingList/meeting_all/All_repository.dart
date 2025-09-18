import 'package:dio/dio.dart';
import 'package:travell_booking_app/models/visitList/visit_list.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/response_model.dart';
import '../../../../data/services/api_services.dart';

class AllRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<ApiResponse<List<VisitList>>> getVisitList({
    int page = 1,
    int pageSize = 20,
  }) async {
    _cancelToken = CancelToken();

    final queryParameters = <String, dynamic>{
      'page': page,
      'page_size': pageSize,
    };

    return await _apiServices.getList<VisitList>(
      ApiConstants1.getVisitList,
          (data) => VisitList.fromJson(data as Map<String, dynamic>),
      queryParameters: queryParameters,
      cancelToken: _cancelToken,
    );
  }

  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}
