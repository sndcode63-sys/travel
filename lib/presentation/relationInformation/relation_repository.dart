import '../../core/constants/api_constants.dart';
import '../../data/services/api_services.dart';
import '../../models/profiles/address_profile_model.dart';

class RelationRepository {
  static final _apiServices = ApiServices();

  static Future<AddressProfileModel> changePass({
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    return await _apiServices.post<AddressProfileModel>(
      ApiConstants1.updateAssociateProfile,
          (json) => AddressProfileModel.fromJson(json),
      data: {
        "oldpassword": oldPassword,
        "password": password,
        "confirmPassword": confirmPassword,
      },
    );
  }
}
