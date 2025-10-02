class AddressProfileModel {
  String? actiontype;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;

  AddressProfileModel({
    this.actiontype,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pincode,
  });

  AddressProfileModel.fromJson(Map<String, dynamic> json) {
    actiontype = json['actiontype'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['actiontype'] = actiontype;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['pincode'] = pincode;
    return data;
  }
}
