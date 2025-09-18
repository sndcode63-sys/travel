import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/response_model.dart';
import '../../../data/services/api_services.dart';
import '../../../models/team/all_downline_list_model.dart';
import '../../../models/team/team_self_model.dart';

class AllDownlineRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  // Get All Users
  Future<ApiResponse<List<AllDownlineListModel>>> getSefList() async {
    _cancelToken = CancelToken();

    final queryParameters = <String, dynamic>{};

    // return await _apiServices.getList<SchemeListData>(
    //   ApiConstants.schemeList,
    //   SchemeListData.fromJson,
    //   queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
    //   cancelToken: _cancelToken,
    // );
    return await _apiServices.getList<AllDownlineListModel>(
      ApiConstants1.allDownlineList,
          (data) => AllDownlineListModel.fromJson(data as Map<String, dynamic>),
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      cancelToken: _cancelToken,
    );

  }


  void cancelRequest(){
    _cancelToken?.cancel("Request cancelled by the user");
  }

}
