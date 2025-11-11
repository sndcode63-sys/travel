import '../User/user_models.dart';
import 'data.dart';

class LoginModels {
  int? status;
  String? message;
  String? firebaseToken;
  Data1? data;
  UserModels? user;
  bool? isVerified; // 👈 Add this line

  LoginModels({
    this.status,
    this.message,
    this.firebaseToken,
    this.data,
    this.user,
    this.isVerified,
  });

  LoginModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    firebaseToken = json['firebase_token'];
    data = json['data'] != null ? Data1.fromJson(json['data']) : null;
    user = json['user'] != null ? UserModels.fromJson(json['user']) : null;
    isVerified = json['is_verified'] ?? json['email_verified'] ?? false;
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'firebase_token': firebaseToken,
    'data': data?.toJson(),
    'user': user?.toJson(),
    'is_verified': isVerified,
  };
}
