
class   RelationGet {
  int? status;
  List<Teams>? teams;
  List<Pin>? pin;
  List<CustomLocation>? location;
  List<ReraSerial>? reraSerial;
  String? currentReraNumber;
  String? message;

  RelationGet({
    this.status,
    this.teams,
    this.pin,
    this.location,
    this.reraSerial,
    this.currentReraNumber,
    this.message,
  });

  factory RelationGet.fromJson(Map<String, dynamic> json) {
    return RelationGet(
      status: json['status'],
      teams: json['teams'] != null
          ? List<Teams>.from(json['teams'].map((x) => Teams.fromJson(x)))
          : null,
      pin: json['pin'] != null
          ? List<Pin>.from(json['pin'].map((x) => Pin.fromJson(x)))
          : null,
      location: json['location'] != null
          ? List<CustomLocation>.from(
          json['location'].map((x) => CustomLocation.fromJson(x)))
          : null,
      reraSerial: json['rera_serial'] != null
          ? List<ReraSerial>.from(
          json['rera_serial'].map((x) => ReraSerial.fromJson(x)))
          : null,
      currentReraNumber: json['current_rera_number'],
      message: json['message'],
    );
  }
}
  class Teams {
    int? id;
    String? name;
    Teams({this.id, this.name});
    factory Teams.fromJson(Map<String, dynamic> json) => Teams(id: json['id'], name: json['name']);
  }

  class Pin {
    int? id;
    String? name;
    Pin({this.id, this.name});
    factory Pin.fromJson(Map<String, dynamic> json) => Pin(id: json['id'], name: json['name']);
  }

  class CustomLocation {
    int? id;
    String? name;
    CustomLocation({this.id, this.name});
    factory CustomLocation.fromJson(Map<String, dynamic> json) => CustomLocation(id: json['id'], name: json['name']);
  }

  class ReraSerial {
    int? id;
    String? name;
    ReraSerial({this.id, this.name});
    factory ReraSerial.fromJson(Map<String, dynamic> json) => ReraSerial(id: json['id'], name: json['name']);
  }
