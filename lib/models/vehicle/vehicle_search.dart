
import '../../core/constants/api_constants.dart';

class VehicleSearch {
  String? registrationNumber;
  String? modelName;
  String? name;
  int? associateId;
  String? brand;
  String? color;
  String? type;
  String? photo;
  String? status;
  String? id;
  String? base64Image;
  String? visitStatus;

  VehicleSearch(
      {this.registrationNumber,
        this.modelName,
        this.name,
        this.associateId,
        this.brand,
        this.color,
        this.type,
        this.photo,
        this.status,
        this.id,
        this.base64Image,
        this.visitStatus});

  VehicleSearch.fromJson(Map<String, dynamic> json) {
    registrationNumber = json['registration_number'];
    modelName = json['model_name'];
    name = json['name'];
    associateId = json['associate_id'];
    brand = json['brand'];
    color = json['color'];
    type = json['type'];
    photo = json['photo'];
    status = json['status'];
    id = json['id'];
    base64Image = json['base64_image'];
    visitStatus = json['visit_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registration_number'] = registrationNumber;
    data['model_name'] = modelName;
    data['name'] = name;
    data['associate_id'] = associateId;
    data['brand'] = brand;
    data['color'] = color;
    data['type'] = type;
    data['photo'] = photo;
    data['status'] = status;
    data['id'] = id;
    data['base64_image'] = base64Image;
    data['visit_status'] = visitStatus;
    return data;
  }

  String get fullImageUrl => ApiConstants1.imagePath;

}
