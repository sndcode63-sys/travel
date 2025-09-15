import 'package:get/get.dart';
import 'package:travell_booking_app/models/scheme/scheme_list.dart';
import 'package:travell_booking_app/utlis/constents/api_constants.dart';

import '../../core/api/api_service.dart';
import '../../core/api/base_response.dart';
import '../../models/scheme/scheme_list_data.dart';


class SchemeRepository {
  SchemeRepository._();
  static final instance = SchemeRepository._();

  Future<List<SchemeListData>> getSchemeList() async {
    final response = await ApiService.getApi(
      ApiConstants.schemeList,
      fromJson: (json) {
        if (json['status'] == 200 && json['data'] != null) {
          return (json['data'] as List)
              .map((e) => SchemeListData.fromJson(e))
              .toList();
        }
        return <SchemeListData>[];
      },
    );

    if (response.isSuccess) {
      return response.data ?? [];
    } else {
      throw Exception(response.errorMessage ?? 'Failed to fetch schemes');
    }
  }
}
