class UpdateVehicleModel {
  String? id;
  String? registrationNumber;
  String? modelName;
  String? brand;
  String? type;
  String? color;
  String? fileSource;
  int? status;
  String? message;

  UpdateVehicleModel(
      {this.id,
        this.registrationNumber,
        this.modelName,
        this.brand,
        this.type,
        this.color,
        this.fileSource,
        this.status,
        this.message,});

  UpdateVehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registrationNumber = json['registration_number'];
    modelName = json['model_name'];
    brand = json['brand'];
    type = json['type'];
    color = json['color'];
    fileSource = json['fileSource'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['registration_number'] = registrationNumber;
    data['model_name'] = modelName;
    data['brand'] = brand;
    data['type'] = type;
    data['color'] = color;
    data['fileSource'] = fileSource;
    return data;
  }
}
