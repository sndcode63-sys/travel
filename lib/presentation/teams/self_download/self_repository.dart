import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/response_model.dart';
import '../../../data/services/api_services.dart';
import '../../../models/scheme/scheme_list_data.dart';
import '../../../models/team/team_self_model.dart';

class SelfRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  // Get All Users
  Future<ApiResponse<List<TeamSelfModel>>> getSefList() async {
    _cancelToken = CancelToken();

    final queryParameters = <String, dynamic>{};

    // return await _apiServices.getList<SchemeListData>(
    //   ApiConstants.schemeList,
    //   SchemeListData.fromJson,
    //   queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    //   cancelToken: _cancelToken,
    // );
    return await _apiServices.getList<TeamSelfModel>(
      ApiConstants1.selfList,
          (data) => TeamSelfModel.fromJson(data as Map<String, dynamic>),
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      cancelToken: _cancelToken,
    );

  }


  void cancelRequest(){
    _cancelToken?.cancel("Request cancelled by the user");
  }

}
