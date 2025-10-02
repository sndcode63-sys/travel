class Pingetmodel {
  int? status;
  List<String>? area;
  List<String>? city;
  List<String>? district;
  List<String>? state;
  List<String>? country;

  Pingetmodel({
    this.status,
    this.area,
    this.city,
    this.district,
    this.state,
    this.country,
  });

  Pingetmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    if (json['area'] != null) {
      area = List<String>.from(json['area']);
    }

    if (json['city'] != null) {
      if (json['city'] is List) {
        city = List<String>.from(json['city']);
      } else if (json['city'] is Map) {
        city = (json['city'] as Map).values.map((e) => e.toString()).toList();
      }
    }

    if (json['District'] != null) {
      district = List<String>.from(json['District']);
    }

    if (json['State'] != null) {
      state = List<String>.from(json['State']);
    }

    if (json['Country'] != null) {
      country = List<String>.from(json['Country']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['area'] = area;
    data['city'] = city;
    data['District'] = district;
    data['State'] = state;
    data['Country'] = country;
    return data;
  }
}
