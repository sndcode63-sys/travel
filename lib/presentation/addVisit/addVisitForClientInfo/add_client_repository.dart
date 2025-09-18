import 'package:travell_booking_app/core/constants/api_constants.dart';

import '../../../core/response_model.dart';
import '../../../data/services/api_services.dart';
import '../../../models/saveVisit/save_visit_conte.dart';

class SaveVisitRepository {
  final ApiServices _apiServices = ApiServices();

  Future<ApiResponse<SaveVisitConte>> saveVisit(SaveVisitConte visit) async {
    return await _apiServices.post<SaveVisitConte>(
      ApiConstants1.saveVisit,
          (json) => SaveVisitConte.fromJson(json),
      data: visit.toJson(),
    );
  }
}
