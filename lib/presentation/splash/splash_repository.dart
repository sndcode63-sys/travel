import '../../data/services/api_services.dart';
import '../../models/User/user_models.dart';
import '../../core/constants/api_constants.dart';

class UserRepository {
  final ApiServices _apiServices = ApiServices();
  Future<UserModels> getUserDetails() async {
    return await _apiServices.get(
      ApiConstants1.getUserDetails,
          (json) => UserModels.fromJson(json['data']),
    );
  }
}
