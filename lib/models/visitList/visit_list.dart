// class VisitList {
//   int? status;
//   List<Data>? data;
//
//   VisitList({this.status, this.data});
//
//   VisitList.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

import 'package:travell_booking_app/core/constants/api_constants.dart';

class VisitList {
  int? id;
  String? name;
  String? fatherName;
  String? email;
  String? phone;
  String? visitDate;
  String? photo;
  String? visitStatus;
  String? submitTime;
  String? schemeName;
  String? base64Image;

  VisitList(
      {this.id,
        this.name,
        this.fatherName,
        this.email,
        this.phone,
        this.visitDate,
        this.photo,
        this.visitStatus,
        this.submitTime,
        this.schemeName,
        this.base64Image});

  VisitList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fatherName = json['father_name'];
    email = json['email'];
    phone = json['phone'];
    visitDate = json['visit_date'];
    photo = json['photo'];
    visitStatus = json['visit_status'];
    submitTime = json['submit_time'];
    schemeName = json['scheme_name'];
    base64Image = json['base64_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['father_name'] = fatherName;
    data['email'] = email;
    data['phone'] = phone;
    data['visit_date'] = visitDate;
    data['photo'] = photo;
    data['visit_status'] = visitStatus;
    data['submit_time'] = submitTime;
    data['scheme_name'] = schemeName;
    data['base64_image'] = base64Image;
    return data;
  }

  String get fullImageUrl => ApiConstants1.imagePath;
}
