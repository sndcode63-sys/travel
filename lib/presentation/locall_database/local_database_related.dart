import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class DistributorRetailerModel extends HiveObject {
  @HiveField(0)
  int type; // 0 = Distributor, 1 = Retailer

  @HiveField(1)
  String businessName;

  @HiveField(2)
  String businessType;

  @HiveField(3)
  String brand;

  @HiveField(4)
  String address;

  @HiveField(5)
  String state;

  @HiveField(6)
  String city;

  @HiveField(7)
  String region;

  @HiveField(8)
  String area;

  @HiveField(9)
  String bankName;

  @HiveField(10)
  String gstNo;

  @HiveField(11)
  String pinCode;

  @HiveField(12)
  String personName;

  @HiveField(13)
  String mobile;

  @HiveField(14)
  String? imagePath;

  DistributorRetailerModel({
    required this.type,
    required this.businessName,
    required this.businessType,
    required this.brand,
    required this.address,
    required this.state,
    required this.city,
    required this.region,
    required this.area,
    required this.bankName,
    required this.gstNo,
    required this.pinCode,
    required this.personName,
    required this.mobile,
    this.imagePath,
  });
}
