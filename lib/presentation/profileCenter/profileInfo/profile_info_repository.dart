import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/profiles/address_profile_model.dart';
import '../../../models/profiles/pinGetModel.dart';



class ProfileInfoRepository {
  static final _apiServices = ApiServices();

  static Future<AddressProfileModel> updateProfile(AddressProfileModel model) async {
    return await _apiServices.post<AddressProfileModel>(
      ApiConstants1.updateAssociateProfile,
          (json) => AddressProfileModel.fromJson(json),
      data: model.toJson(),
    );
  }

  static Future<Pingetmodel> fetchAddressFromPin(String pin) async {
    final data = {"pin_code": pin};

    return await _apiServices.post<Pingetmodel>(
      ApiConstants1.getDetailsFromPinCode,
          (json) => Pingetmodel.fromJson(json),
      data: data,
    );
  }
}
