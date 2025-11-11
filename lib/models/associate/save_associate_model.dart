class SaveAssociateModel {
  int? status;
  String? message;
  Data? data;

  SaveAssociateModel({this.status, this.message, this.data});

  SaveAssociateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) map['data'] = data!.toJson();
    return map;
  }
}

class Data {
  String? associateId;

  Data({this.associateId});

  Data.fromJson(Map<String, dynamic> json) {
    associateId = json["associate_id"];
  }

  Map<String, dynamic> toJson() {
    return {"associate_id": associateId};
  }
}
