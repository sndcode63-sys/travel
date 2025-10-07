import 'dart:convert';
import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/complain/complaint_dispute.dart';

class DisputeEnterRepository {
  static final _apiServices = ApiServices();

  static Future<ComplaintDispute> updateDispute({
    required String caseInDetails,
    required String subject,
    required String staffName,
  }) async {
    return await _apiServices.post<ComplaintDispute>(
      ApiConstants1.saveInternalDispute,
          (data) {
        // Some APIs return a raw String, so we decode if needed
        final responseData = (data is String) ? json.decode(data) : data;
        return ComplaintDispute.fromJson(responseData);
      },
      data: {
        "dispute_type": "Staff",
        "case_in_details": caseInDetails,
        "subject": subject,
        "staff_name": staffName,
      },
    );
  }
}
