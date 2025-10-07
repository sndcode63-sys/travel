import 'package:dio/dio.dart';
import 'package:travell_booking_app/models/complain/associate_model.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/response_model.dart';
import '../../../data/services/api_services.dart';
import '../../../models/complain/staff_search.dart';
import '../../../models/scheme/scheme_list_data.dart';
import '../../../models/team/team_self_model.dart';


class Repository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<List<AssociateModel>> searchUsers({
    required String searchText,
    String userType = "Associate",
  }) async {
    _cancelToken = CancelToken();

    final body = {
      "searchText": searchText,
      "usertype": userType,
    };

    return await _apiServices.post<List<AssociateModel>>(
      ApiConstants1.searchUserData,
          (data) {
        final List<dynamic> jsonList = data['data'] ?? [];
        return jsonList.map((json) => AssociateModel.fromJson(json)).toList();
      },
      data: body,
      cancelToken: _cancelToken,
    );
  }

  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}
