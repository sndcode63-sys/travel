import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/response_model.dart';
import '../../data/services/api_services.dart';
import '../../models/meetingList/meeting_list.dart';
import '../../models/visitList/visit_list.dart';

class MeetingRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<List<MeetingList>> getVisitList({
    int page = 1,
    int pageSize = 10,
  }) async {
    _cancelToken = CancelToken();

    final queryParameters = {
      'page': page,
      'page_size': pageSize,
    };

    return await _apiServices.getList<MeetingList>(
      ApiConstants1.meeting,
          (data) => MeetingList.fromJson(data),
      queryParameters: queryParameters,
      cancelToken: _cancelToken,
    );
  }

  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}
