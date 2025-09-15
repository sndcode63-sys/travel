import '../../models/User/data.dart';

class CommonResponse {
  int? status;
  String? message;
  Data? data;
  List<Data>? dataList; 

  CommonResponse({this.status, this.message, this.data, this.dataList});

  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null && json['data'] is Map<String, dynamic>
          ? Data.fromJson(json['data'])
          : null,
      dataList: json['data'] != null && json['data'] is List
          ? List<Data>.from(json['data'].map((x) => Data.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
    'dataList': dataList?.map((x) => x.toJson()).toList(),
  };
}

