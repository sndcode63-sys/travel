import 'package:get/get.dart';
import '../../core/constants/api_constants.dart';

class VehicleList {
  String? id;
  String? registrationNumber;
  String? modelName;
  String? brand;
  String? color;
  String? type;
  String? photo;
  String? status;
  int? active;
  int? userId;
  String? userType;
  String? reason;
  int? entryBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? brandName;
  String? base64Image;
  String? visitStatus;
  String? name;

  // Reactive variable for toggle or switch UI
  RxBool isOn = false.obs;

  VehicleList({
    this.id,
    this.registrationNumber,
    this.modelName,
    this.brand,
    this.color,
    this.type,
    this.photo,
    this.status,
    this.active,
    this.userId,
    this.userType,
    this.reason,
    this.entryBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.brandName,
    this.base64Image,
    this.visitStatus,
    this.name,
  });

  VehicleList.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? json['_id']?.toString(); // ✅ fixed
    registrationNumber = json['registration_number'];
    modelName = json['model_name'];
    brand = json['brand'];
    color = json['color'];
    type = json['type'];
    photo = json['photo'];
    status = json['status'];
    active = json['active'];
    userId = json['user_id'];
    userType = json['user_type'];
    reason = json['reason'];
    entryBy = json['entry_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    brandName = json['brand_name'];
    base64Image = json['base64_image'];
    visitStatus = json['visit_status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['registration_number'] = registrationNumber;
    data['model_name'] = modelName;
    data['brand'] = brand;
    data['color'] = color;
    data['type'] = type;
    data['photo'] = photo;
    data['status'] = status;
    data['active'] = active;
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['reason'] = reason;
    data['entry_by'] = entryBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['brand_name'] = brandName;
    data['base64_image'] = base64Image;
    data['visit_status'] = visitStatus;
    data['name'] = name;
    return data;
  }

  String get fullImageUrl => ApiConstants1.imagePath;


  @override
  String toString() {
    return 'VehicleList(id: $id, registrationNumber: $registrationNumber, modelName: $modelName, brand: $brand)';
  }
}
