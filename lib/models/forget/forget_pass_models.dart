// class ForgetPassModels {
//   int? status;
//   String? message;
//
//   ForgetPassModels({this.status, this.message});
//
//   ForgetPassModels.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     return data;
//   }
// }

class ForgetPassModels {
  final int status;
  final String? message;

  ForgetPassModels({
    required this.status,
    this.message,
  });

  factory ForgetPassModels.fromJson(Map<String, dynamic> json) {
    return ForgetPassModels(
      status: json['status'] ?? 0,
      message: json['message']?.toString(), // बस message
    );
  }
}


