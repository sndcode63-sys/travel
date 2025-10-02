// import 'package:dio/dio.dart';
//
// import '../../../core/constants/api_constants.dart';
// import '../../../data/services/api_services.dart';
// import '../../../models/setting/support.dart';
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
//
// // ==================== Model ====================
// class Support {
//   String? supportEmailAddress;
//   String? supportContactNumber;
//
//   Support({this.supportEmailAddress, this.supportContactNumber});
//
//   Support.fromJson(Map<String, dynamic> json) {
//     supportEmailAddress = json['support_email_address'];
//     supportContactNumber = json['support_contact_number'];
//   }
//
//   Map<String, dynamic> toJson() => {
//     'support_email_address': supportEmailAddress,
//     'support_contact_number': supportContactNumber,
//   };
// }
//
// ==================== Repository ====================
import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../data/services/api_services.dart';
import '../../../models/setting/support.dart';






class HelpSupportRepository {
  final ApiServices _apiServices = ApiServices();
  CancelToken? _cancelToken;

  Future<Support> getSupportDetails() async {
    _cancelToken = CancelToken();

    final response = await _apiServices.get<Support>(
      ApiConstants1.supportDetails,
          (data) => Support.fromJson(Map<String, dynamic>.from(data['data'])),
      cancelToken: _cancelToken,
    );

    return response;
  }

  void cancelRequest() {
    _cancelToken?.cancel("Request cancelled by the user");
  }
}



//
//
//
//
//
//
//
