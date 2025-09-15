import 'package:travell_booking_app/models/scheme/scheme_list_data.dart';

class SchemeList {
  int? status;
  List<SchemeListData>? data;
  String? message;

  SchemeList({this.status, this.data, this.message});

  SchemeList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SchemeListData>[];
      json['data'].forEach((v) {
        data!.add(SchemeListData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

