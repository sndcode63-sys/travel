import 'package:dio/dio.dart';
import 'package:travell_booking_app/models/profiles/relation_get.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../models/profiles/post_relation_model.dart';



class RelationRepository {
  final _apiServices = ApiServices();
  CancelToken? _cancelToken;

  // GET API
  Future<RelationGet> getSefList() async {
    _cancelToken = CancelToken();
    return await _apiServices.get<RelationGet>(
      ApiConstants1.relationGetMasterAll,
          (json) => RelationGet.fromJson(json as Map<String, dynamic>),
      cancelToken: _cancelToken,
    );
  }
  void cancelRequest() => _cancelToken?.cancel("Request cancelled");


  // POST API
  static Future<PostRelationModel> updateRelationInfo({
    required int reraSerialId,
    required String reraNumber,
    required int teamId,
    required int pinId,
    required int locationId,
  }) async {
    return await ApiServices().post<PostRelationModel>(
      ApiConstants1.updateAssociateProfile,
          (json) => PostRelationModel.fromJson(json),
      data: {
        "actiontype": "relation-information",
        "rera_serial": reraSerialId, // send ID
        "rera_number": reraNumber,
        "team_name": teamId,
        "pin_name": pinId,
        "location_name": locationId,
      },
    );
  }

}
