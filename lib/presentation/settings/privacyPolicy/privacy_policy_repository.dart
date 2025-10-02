import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/setting/privacy_model.dart';


class PrivacyPolicyRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<PrivacyModel> getPrivacyPolicy() async {
    _cancelToken = CancelToken();
    final response = await _apiServices.get(
      ApiConstants1.getPrivacyPolicy,
          (data) => PrivacyModel.fromJson(data),
      cancelToken: _cancelToken,
    );
    return response;
  }

  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by user");
  }
}
