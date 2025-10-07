// class StaffListSearch {
//   int? status;
//   List<Data>? data;
//   String? message;
//
//   StaffListSearch({this.status, this.data, this.message});
//
//   StaffListSearch.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }

class StaffSearch {
  String? id;
  String? fullname;
  String? email;
  String? phonenumber;
  String? designationName;

  StaffSearch(
      {this.id,
        this.fullname,
        this.email,
        this.phonenumber,
        this.designationName});

  StaffSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    designationName = json['designation_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    data['designation_name'] = this.designationName;
    return data;
  }
}
