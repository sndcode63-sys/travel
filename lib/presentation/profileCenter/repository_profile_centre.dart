import 'package:dio/dio.dart';
import '../../data/services/api_services.dart';
import '../../core/constants/api_constants.dart';
import '../../models/User/user_models.dart';
import '../../models/associate/associate_details_get.dart';
import '../../models/home/home_page_view_builder_loader.dart';

class RepositoryProfileCentre {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;


  Future<AssociateDetailsGet> getAssociateUser() async {
    _cancelToken = CancelToken();
    final response = await _apiServices.get(
      ApiConstants1.getUserAssociate,
          (json) {
        final dataList = json['data'] as List<dynamic>;
        if (dataList.isNotEmpty) {
          return AssociateDetailsGet.fromJson(dataList[0]);
        } else {
          return AssociateDetailsGet();
        }
      },
      cancelToken: _cancelToken,
    );
    return response;
  }

  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}
