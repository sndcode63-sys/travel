class NotifyModel {
  String? vehicleid;
  String? description;
  String? vehicleImage;
  int? status;
  String? message;

  NotifyModel({this.vehicleid, this.description, this.vehicleImage,    this.status,
    this.message,});

  NotifyModel.fromJson(Map<String, dynamic> json) {
    vehicleid = json['vehicleid'];
    description = json['description'];
    vehicleImage = json['vehicle_image'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicleid'] = vehicleid;
    data['description'] = description;
    data['vehicle_image'] = vehicleImage;
    return data;
  }
}
