import 'package:dio/dio.dart';
import '../../data/services/api_services.dart';
import '../../core/constants/api_constants.dart';
import '../../models/User/user_models.dart';
import '../../models/home/home_page_view_builder_loader.dart';

class HomeRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<List<HomePageViewBuilderLoader>> getSch() async {
    _cancelToken = CancelToken();
    return await _apiServices.getList<HomePageViewBuilderLoader>(
      ApiConstants1.homeSlider,
          (data) => HomePageViewBuilderLoader.fromJson(data),
      cancelToken: _cancelToken,
    );
  }

  Future<UserModels> getDataUser() async {
    _cancelToken = CancelToken();
    final response = await _apiServices.get(
      ApiConstants1.getUserDetails,
          (json) => UserModels.fromJson(json['data']),
      cancelToken: _cancelToken,
    );
    return response;
  }

  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}
