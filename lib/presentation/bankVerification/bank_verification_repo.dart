import 'package:travell_booking_app/core/constants/api_constants.dart';
import '../../data/services/api_services.dart';
import '../../models/profiles/bank_info_model.dart';
import '../../models/profiles/getBankModel.dart';

class BankInfoRepository {
  static final _apiServices = ApiServices();

  // 🔹 Update bank info — return response
  static Future<BankInfoModel> updateBankInfo(BankInfoModel model) async {
    final response = await _apiServices.post<BankInfoModel>(
      ApiConstants1.updateAssociateProfile,
          (json) => BankInfoModel.fromJson(json),
      data: model.toJson(),
    );
    return response;
  }

  // Get bank details by IFSC
  static Future<Getbankmodel> getBankByIfsc(String ifsc) async {
    final response = await _apiServices.post<Getbankmodel>(
      ApiConstants1.getBankDetailsFromIfscCode,
          (json) => Getbankmodel.fromJson(json),
      data: {"ifsc": ifsc},
    );
    return response;
  }
}
