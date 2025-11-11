import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/associate/save_associate_model.dart';
import '../../../models/profiles/general_info.dart';

class RepositoryAddAssociate {
  static final _apiServices = ApiServices();

  static Future<SaveAssociateModel> updateGeneralInfo({
    String? associateId,
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
    final payload = {
      if (associateId != null) "associate_id": associateId, // send if editing
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
    };

    return await _apiServices.post<SaveAssociateModel>(
      ApiConstants1.saveAssociateData,
          (json) => SaveAssociateModel.fromJson(json),
      data: payload,
    );
  }
}
