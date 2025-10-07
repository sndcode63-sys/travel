class CommonResponseModel<T> {
  final int status;
  final String message;
  final T? data;

  CommonResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory CommonResponseModel.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic) fromJson,
      ) {
    return CommonResponseModel<T>(
      status: json['status'] ?? 0,
      message: json['message'] ?? "",
      data: json['data'] != null ? fromJson(json['data']) : null,
    );
  }
}
