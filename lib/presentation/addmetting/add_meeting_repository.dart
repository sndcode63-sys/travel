import 'dart:io';



import 'package:travell_booking_app/core/constants/api_constants.dart';

import '../../core/response_model.dart';
import '../../data/services/api_services.dart';
import '../../models/saveVisit/add_meeting_model.dart';

class AddMeetingRepository {
  final ApiServices _apiServices = ApiServices();

  Future<AddMeetingModel> saveMeeting({
    required AddMeetingModel meeting,
  }) async {
    return await _apiServices.post<AddMeetingModel>(
      ApiConstants1.saveMeeting,
          (json) => AddMeetingModel.fromJson(json),
      data: meeting.toJson(),
    );
  }
}

