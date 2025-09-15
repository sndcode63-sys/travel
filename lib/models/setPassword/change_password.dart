class ChangePassword {
  int? status;
  String? message;
  String? firebaseToken;

  ChangePassword({this.status, this.message, this.firebaseToken});

  ChangePassword.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    firebaseToken = json['firebase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['firebase_token'] = firebaseToken;
    return data;
  }
}
