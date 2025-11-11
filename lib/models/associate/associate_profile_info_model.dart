class AssociateProfileInfoModel {
  String? associateId;
  String? actiontype;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;
  int? status;
  String? message;

  AssociateProfileInfoModel({
    this.associateId,
    this.actiontype,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,
      this.message,
      this.status
  });

  AssociateProfileInfoModel.fromJson(Map<String, dynamic> json) {
    associateId = json["associate_id"];
    actiontype = json["actiontype"];
    address = json["address"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    pincode = json["pincode"];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["associate_id"] = associateId;
    data["actiontype"] = actiontype;
    data["address"] = address;
    data["city"] = city;
    data["state"] = state;
    data["country"] = country;
    data["pincode"] = pincode;
    return data;
  }
}
