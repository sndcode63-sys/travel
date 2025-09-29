import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/profiles/general_info.dart';

class RepositoryGeneralProfile {
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
      ApiConstants1.generalInfoUpdate,
          (json) {
        if (json is Map<String, dynamic>) {
          return GeneralInfoModel.fromJson(json);
        } else {
            return GeneralInfoModel(
            name: name,
            fatherName: fatherName,
            motherName: motherName,
            spouseName: spouseName,
            email: email,
            phone1: phone,
            date: date,
            month: month,
            year: year,
            gender: gender,
            nomineeRelation: nomineeRelation,
            nomineeName: nomineeName,
          );
        }
      },
      data: {
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
}
