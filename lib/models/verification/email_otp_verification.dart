
class EmailOtpVerification {
  String? type;
  String? email;
  String? code;

  EmailOtpVerification({this.type, this.email, this.code});

  EmailOtpVerification.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    email = json["email"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["email"] = email;
    data["code"] = code;
    return data;
  }
}