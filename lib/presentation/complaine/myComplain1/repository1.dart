import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/response_model.dart';
import '../../../data/services/api_services.dart';
import '../../../models/complain/get_dispute.dart';
import '../../../models/complain/staff_search.dart';
import '../../../models/scheme/scheme_list_data.dart';
import '../../../models/team/team_self_model.dart';


class Repository1 {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;


  // POST SE GET LIST KARNA
  Future<List<Data>> getMyDisputeList() async {
    final body = {
      "dispute_type": "my_dispute",
    };

    return await _apiServices.post<List<Data>>(
      ApiConstants1.getDisputeData,
          (data) {
        final List<dynamic> jsonList = data['data'] ?? [];
        return jsonList.map((e) => Data.fromJson(e)).toList();
      },
      data: body,
    );
  }

  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}
