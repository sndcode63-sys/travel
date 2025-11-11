class DeelteVehicle {
  String? vehicleid;

  DeelteVehicle({this.vehicleid});

  DeelteVehicle.fromJson(Map<String, dynamic> json) {
    vehicleid = json['vehicleid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleid'] = this.vehicleid;
    return data;
  }
}
