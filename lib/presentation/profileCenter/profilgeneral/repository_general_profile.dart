import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/profiles/general_info.dart';


class GeneralProfileRepository {
  static final _apiServices = ApiServices();

  static Future<GeneralInfoModel> updateGeneralInfo({
    required String name,
    required String fatherName,
    required String motherName,
    required String spouseName,
    required String email,
    required String phone,
    required String date,
    required String month,
    required String year,
    required String gender,
    required String nomineeRelation,
    required String nomineeName,
  }) async {
    return await _apiServices.post<GeneralInfoModel>(
      ApiConstants1.updateAssociateProfile,
          (json) => GeneralInfoModel.fromJson(json),
      data: {
        "actiontype": "general-information",
        "name": name,
        "father_name": fatherName,
        "mother_name": motherName,
        "spouse_name": spouseName,
        "email": email,
        "phone_1": phone,
        "date": date,
        "month": month,
        "year": year,
        "gender": gender,
        "nominee_relation": nomineeRelation,
        "nominee_name": nomineeName,
      },
    );
  }

  static Future<GeneralInfoModel> getProfile() async {
    return await _apiServices.get<GeneralInfoModel>(
      ApiConstants1.updateAssociateProfile, // replace with GET profile endpoint
          (json) => GeneralInfoModel.fromJson(json),
    );
  }
}
