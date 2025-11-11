import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/associate/associate_profile_info_model.dart';
import '../../../models/profiles/address_profile_model.dart';
import '../../../models/profiles/pinGetModel.dart';



class AssociateProfileInfoRepository {
  static final _apiServices = ApiServices();

  static Future<AssociateProfileInfoModel> associateProfile(AssociateProfileInfoModel model) async {
    return await _apiServices.post<AssociateProfileInfoModel>(
      ApiConstants1.saveAssociateData,
          (json) => AssociateProfileInfoModel.fromJson(json),
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
