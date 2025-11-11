import 'package:travell_booking_app/core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/associate/associate_bank_info.dart';
import '../../../models/profiles/getBankModel.dart';


class AssociateBankInfoRepository {
  static final _apiServices = ApiServices();

  static Future<AssociateBankInfo> associateUpdateBankInfo(AssociateBankInfo model) async {
    final response = await _apiServices.post<AssociateBankInfo>(
      ApiConstants1.saveAssociateData,
          (json) => AssociateBankInfo.fromJson(json),
      data: model.toJson(),
    );
    return response;
  }

  static Future<Getbankmodel> getBankByIfsc(String ifsc) async {
    final response = await _apiServices.post<Getbankmodel>(
      ApiConstants1.getBankDetailsFromIfscCode,
          (json) => Getbankmodel.fromJson(json),
      data: {"ifsc": ifsc},
    );
    return response;
  }
}
