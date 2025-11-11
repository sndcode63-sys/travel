class SavePanModel {
  String? type;
  String? panNumber;
  int? status;
  String? message;

  SavePanModel({this.type, this.panNumber, this.status, this.message});

  SavePanModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    panNumber = json['panNumber'];
    status = json['status'] ?? 0;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'panNumber': panNumber,
    };
  }
}
