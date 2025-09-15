import 'package:travell_booking_app/utlis/constents/api_constants.dart';

import '../../../core/api/api_service.dart';
import '../../../models/saveVisit/save_visit_conte.dart';

class VisitRepository {
  VisitRepository._();
  static final instance = VisitRepository._();

  Future<bool> saveVisit(SaveVisitConte visit) async {
    try {
      final response = await ApiService.postApi(
        ApiConstants.saveVisit,
        body: visit.toJson(),
      );

      if (response.isSuccess == 200 || response.isSuccess == 201) {
        return true;
      } else {
        print("API Error: ${response.isSuccess}");
        return false;
      }
    } catch (e) {
      print("Error saving visit: $e");
      return false;
    }
  }
}
