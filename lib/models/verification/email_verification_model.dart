
class EmailVerificationModel {
  String? type;
  String? email;
  int? status;
  String? message;

  EmailVerificationModel({this.type, this.email,    this.status,
    this.message,});

  EmailVerificationModel.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    email = json["email"];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["email"] = email;
    return data;
  }
}