import 'data.dart';

class LoginModels {
  int? status;
  String? message;
  String? firebaseToken;
  Data1? data;

  LoginModels({this.status, this.message, this.firebaseToken, this.data});

  LoginModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    firebaseToken = json['firebase_token'];
    data = json['data'] != null ? Data1.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'firebase_token': firebaseToken,
    'data': data?.toJson(),
  };
}

