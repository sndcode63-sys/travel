import 'package:dio/dio.dart';
import 'package:travell_booking_app/models/profiles/relation_get.dart';
import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/associate/associate_relation_info.dart';



class AssociateRelationRepository {
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
  static Future<AssociateRelationInfo> updateRelationInfo({
    required int reraSerialId,
    required String reraNumber,
    required int teamId,
    required int pinId,
    required int locationId,
    required String id,
  }) async {
    return await ApiServices().post<AssociateRelationInfo>(
      ApiConstants1.saveAssociateData,
          (json) => AssociateRelationInfo.fromJson(json),
      data: {
        "actiontype": "relation-information",
        "associate_id": id,
        "rera_serial": reraSerialId.toString(),
        "rera_number": reraNumber,
        "team_name": teamId.toString(),
        "pin_name": pinId.toString(),
        "location_name": locationId.toString(),
      },    );
  }

}
