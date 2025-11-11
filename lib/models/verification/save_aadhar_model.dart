
class SaveAadharModel {
  String? type;
  String? aadharNumber;
  int? status;
  String? message;


  SaveAadharModel({this.type, this.aadharNumber,  this.status,
    this.message,});

  SaveAadharModel.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    aadharNumber = json["aadhar_number"];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    _data["aadhar_number"] = aadharNumber;
    return _data;
  }
}