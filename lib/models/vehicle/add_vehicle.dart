class AddVehicle {
  String? registrationNumber;
  String? modelName;
  String? brand;
  String? type;
  String? color;
  String? fileSource;

  // Use status & message directly from API response
  int? status;
  String? message;

  AddVehicle({
    this.registrationNumber,
    this.modelName,
    this.brand,
    this.type,
    this.color,
    this.fileSource,
    this.status,
    this.message,
  });

  AddVehicle.fromJson(Map<String, dynamic> json) {
    registrationNumber = json['registration_number'];
    modelName = json['model_name'];
    brand = json['brand'];
    type = json['type'];
    color = json['color'];
    fileSource = json['fileSource'];

    // API response fields
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['registration_number'] = registrationNumber;
    data['model_name'] = modelName;
    data['brand'] = brand;
    data['type'] = type;
    data['color'] = color;
    data['fileSource'] = fileSource;
    return data;
  }
}
